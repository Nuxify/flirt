import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:live_activities/live_activities.dart';
import 'package:live_activities/models/activity_update.dart';

class LiveActivitiesService {
  LiveActivitiesService._();

  static final LiveActivitiesService instance = LiveActivitiesService._();
  final LiveActivities client = LiveActivities();

  final List<LiveActivityData> _liveActivities = <LiveActivityData>[];

  /// Public read-only view of current live activities created by this service.
  List<LiveActivityData> get liveActivities =>
      List<LiveActivityData>.unmodifiable(_liveActivities);

  StreamSubscription<String>? _pushToStartSub;
  StreamSubscription<ActivityUpdate>? _activityUpdateSub;
  String? _latestPushToStartToken;
  String? _lastRegisteredPushToStartToken;

  // Network backend removed for demo; no baseUrl/userId required.

  /// Initialize the native live activities client.
  ///
  /// [appGroup] is the App Group identifier used on iOS. [urlScheme] is the
  /// URL scheme used for deep linking. Both have sensible defaults for demo
  /// usage but should be provided for production.
  Future<void> init({
    String appGroup = 'group.com.nuxify.flirt',
    String urlScheme = 'flirt',
  }) {
    debugPrint(
      'LiveActivitiesService: init() starting appGroup=$appGroup urlScheme=$urlScheme',
    );
    final Future<void> iosInit = client.init(
      appGroupId: appGroup,
      urlScheme: urlScheme,
    );

    return Future.wait(<Future<void>>[iosInit])
        .then((List<void> _) {
          debugPrint('LiveActivitiesService: init() completed');
          return null;
        })
        .catchError((Object e) {
          debugPrint('LiveActivitiesService: init() error: $e');
          return null;
        });
  }

  Future<bool> canUseLiveActivities() async {
    final bool isSupported = await client.areActivitiesSupported();
    if (!isSupported) {
      debugPrint('LiveActivitiesService: areActivitiesSupported -> false');
      return false;
    }

    final bool enabled = await client.areActivitiesEnabled();
    debugPrint(
      'LiveActivitiesService: areActivitiesSupported -> true, areActivitiesEnabled -> $enabled',
    );
    return enabled;
  }

  String? _getActivityIdByNotificationId(String notificationId) {
    try {
      return _liveActivities
          .firstWhere(
            (LiveActivityData activity) =>
                activity.notificationId == notificationId,
          )
          .activityId;
    } catch (_) {
      return null;
    }
  }

  Future<bool> isActivityCurrentlyActive(String notificationId) async {
    try {
      final List<String> activitiesIds = await client.getAllActivitiesIds();

      final String? activityId = _getActivityIdByNotificationId(notificationId);

      if (activityId == null) {
        return false;
      }

      return activitiesIds.contains(activityId);
    } catch (_) {
      // If the plugin throws, treat as no active activity.
      return false;
    }
  }

  Future<bool> startLiveActivity(Map<String, dynamic> data) async {
    try {
      debugPrint(
        'LiveActivitiesService: startLiveActivity called with data: $data',
      );
      final bool isSupported = await canUseLiveActivities();
      if (!isSupported) {
        debugPrint(
          'LiveActivitiesService: startLiveActivity aborted - not supported or not enabled',
        );
        return false;
      }

      final String? notificationDataId = data['activityId'] as String?;

      if (notificationDataId == null || notificationDataId.isEmpty) {
        debugPrint(
          'LiveActivitiesService: startLiveActivity missing activityId in payload',
        );
        return false;
      }

      if (await isActivityCurrentlyActive(notificationDataId)) {
        final String existingId = _getActivityIdByNotificationId(
          notificationDataId,
        )!;
        debugPrint(
          'LiveActivitiesService: activity already active for notificationId=$notificationDataId -> updating activityId=$existingId',
        );
        await updateActivity(activityId: existingId, data: data);
        await _registerCachedPushToStartToken();
        return true;
      }

      // If the plugin reports support at runtime, create a live activity.
      debugPrint(
        'LiveActivitiesService: creating activity for notificationId=$notificationDataId',
      );
      final String? createdActivityId = await client.createActivity(
        notificationDataId,
        data,
      );

      debugPrint(
        'LiveActivitiesService: createActivity returned id=$createdActivityId',
      );
      if (createdActivityId == null || createdActivityId.isEmpty) {
        debugPrint(
          'LiveActivitiesService: createActivity failed (null/empty id)',
        );
        return false;
      }

      final String activityId = createdActivityId;

      final String pushToken = await client.getPushToken(activityId) ?? '';
      _liveActivities.add(
        LiveActivityData(
          activityId: activityId,
          notificationId: notificationDataId,
          pushToken: pushToken,
          payload: Map<String, dynamic>.from(data),
        ),
      );

      debugPrint(
        'LiveActivitiesService: activity added activityId=$activityId pushToken=$pushToken',
      );

      await _registerCachedPushToStartToken();

      return true;
    } catch (e) {
      debugPrint('Error starting demo activity: $e');
      return false;
    }
  }

  Future<void> updateActivity({
    required String activityId,
    required Map<String, dynamic> data,
  }) async {
    debugPrint(
      'LiveActivitiesService: updateActivity activityId=$activityId data=$data',
    );
    await client.updateActivity(activityId, data);
    // Update stored payload if we have the activity recorded locally.
    try {
      final int idx = _liveActivities.indexWhere(
        (LiveActivityData a) => a.activityId == activityId,
      );
      if (idx != -1) {
        final LiveActivityData prev = _liveActivities[idx];
        _liveActivities[idx] = LiveActivityData(
          activityId: prev.activityId,
          notificationId: prev.notificationId,
          pushToken: prev.pushToken,
          payload: <String, dynamic>{...prev.payload, ...data},
        );
        debugPrint(
          'LiveActivitiesService: updated stored payload for $activityId',
        );
      }
    } catch (e) {
      debugPrint('LiveActivitiesService: failed to update stored payload: $e');
    }
  }

  Future<void> endActivityById(String activityId) async {
    try {
      debugPrint(
        'LiveActivitiesService: ending activity activityId=$activityId',
      );
      await client.endActivity(activityId);
      _liveActivities.removeWhere(
        (LiveActivityData activity) => activity.activityId == activityId,
      );
    } catch (e) {
      debugPrint('Error ending activity: $e');
    }
  }

  /// End activity using the original notification id used to start it.
  Future<void> endActivityByNotificationId(String notificationId) async {
    final String? activityId = _getActivityIdByNotificationId(notificationId);
    if (activityId == null) return;
    await endActivityById(activityId);
  }

  /// Call on app login/startup.
  Future<void> start() async {
    await _listenPushToStartTokens();
    _listenActivityUpdates();
  }

  /// Call on logout/dispose.
  Future<void> stop() async {
    await _pushToStartSub?.cancel();
    await _activityUpdateSub?.cancel();
    _pushToStartSub = null;
    _activityUpdateSub = null;
  }

  Future<void> _listenPushToStartTokens() async {
    _pushToStartSub?.cancel();

    final bool isPushToStartSupported = await client.allowsPushStart();

    if (isPushToStartSupported) {
      _pushToStartSub = client.pushToStartTokenUpdateStream.listen((
        String token,
      ) async {
        final String trimmedToken = token.trim();
        if (trimmedToken.isEmpty) {
          return;
        }
        _latestPushToStartToken = trimmedToken;
        log('Received push-to-start token update');

        await _registerPushToStartToken(trimmedToken);
      }, onError: (Object error, StackTrace stackTrace) {});
    }
  }

  Future<void> _registerCachedPushToStartToken() async {
    final bool isPushToStartSupported = await client.allowsPushStart();
    if (!isPushToStartSupported) {
      return;
    }

    final String token = (_latestPushToStartToken ?? '').trim();
    if (token.isEmpty) {
      return;
    }

    await _registerPushToStartToken(token);
  }

  Future<void> _registerPushToStartToken(String token) async {
    if (token == _lastRegisteredPushToStartToken) {
      return;
    }

    // In this demo build we don't post the token to a backend. Log instead.
    debugPrint(
      'LiveActivitiesService: registerPushToStartToken skipped network post token=$token',
    );
    _lastRegisteredPushToStartToken = token;
  }

  void _listenActivityUpdates() {
    _activityUpdateSub?.cancel();
    _activityUpdateSub = client.activityUpdateStream.listen(
      (ActivityUpdate event) {
        event.map(
          active: (ActiveActivityUpdate activity) {
            final String activityId = activity.activityId;
            final String activityToken = activity.activityToken;
            log(
              'Live Activity became active: $activityId, token: $activityToken',
            );

            if (activityId.trim().isEmpty || activityToken.trim().isEmpty) {
              return;
            }

            // Skipping backend registration in demo; log the activity instead.
            debugPrint(
              'LiveActivitiesService: activity active (skipped backend) activityId=$activityId token=$activityToken',
            );
          },
          ended: (EndedActivityUpdate activity) {
            final String activityId = activity.activityId;
            if (activityId.trim().isEmpty) {
              return;
            }
            // Skipping backend delete in demo; log the ended activity.
            debugPrint(
              'LiveActivitiesService: activity ended (skipped backend) activityId=$activityId',
            );
          },
          stale: (_) {
            // Optional: refresh token state if your backend needs heartbeat semantics.
          },
          unknown: (_) {
            // Optional: log unknown states.
          },
        );
      },
      onError: (Object error, StackTrace stackTrace) {
        // Replace with your logger.
        // ignore: avoid_print
        print('activityUpdateStream error: $error');
      },
    );
  }

  // Backend network helpers removed for demo.
}

class LiveActivityData {
  LiveActivityData({
    required this.activityId,
    required this.notificationId,
    required this.pushToken,
    required this.payload,
  });

  final String activityId;
  final String notificationId;
  final String pushToken;
  final Map<String, dynamic> payload;
}
