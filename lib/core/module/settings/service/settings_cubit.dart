import 'dart:io';

import 'package:flirt/core/domain/models/api_error_response.dart';
import 'package:flirt/core/domain/models/api_response.dart';
import 'package:flirt/core/domain/models/settings/settings_response.dart';
import 'package:flirt/core/domain/repository/settings_repository.dart';
import 'package:flirt/core/module/settings/service/settings_dto.dart';
import 'package:flirt/internal/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required this.settingsRepository})
    : super(ForceUpgradeInitial());
  final ISettingsRepository settingsRepository;

  // 1️⃣ Remove any leading 'v' and suffixes like '.staging'
  String sanitize(String version) {
    // Normalize casing and remove extra spaces
    String sanitized = version.trim().toLowerCase();

    // Remove leading 'v'
    if (sanitized.startsWith('v')) {
      sanitized = sanitized.substring(1);
    }

    // Keep only digits and dots up to the first invalid character
    sanitized = sanitized.split(RegExp('[^0-9.]'))[0];

    // Remove trailing dots (like '2.2.20.' → '2.2.20')
    sanitized = sanitized.replaceAll(RegExp(r'\.+$'), '');

    return sanitized;
  }

  bool isVersionLower(String localVersion, String latestVersion) {
    final String local = sanitize(localVersion);
    final String latest = sanitize(latestVersion);

    // 2️⃣ Split into parts and convert to int
    final List<int> localParts = local.split('.').map(int.parse).toList();
    final List<int> latestParts = latest.split('.').map(int.parse).toList();

    while (localParts.length < latestParts.length) {
      localParts.add(0);
    }
    while (latestParts.length < localParts.length) {
      latestParts.add(0);
    }

    for (int i = 0; i < localParts.length; i++) {
      if (localParts[i] < latestParts[i]) return true; // local is lower
      if (localParts[i] > latestParts[i]) return false; // local is higher
    }

    return false;
  }

  Future<void> fetchLatestVersion() async {
    try {
      emit(FetchLatestVersionLoading());

      final String remoteConfigId =
          'certifika-${Platform.isIOS ? 'ios' : 'android'}';

      final APIResponse<RemoteConfigResponse> response =
          await settingsRepository.fetchLatestVersion(remoteConfigId);

      final String currentLocalVersion = dotenv.get('VERSION');
      final String currentRemoteVersion = response.data.minimumRequiredVersion;

      emit(
        FetchLatestVersionSuccess(
          remoteConfig: RemoteConfigDTO(
            id: response.data.id,
            storeUrl: response.data.appUrl,
            minimumRequiredVersion: sanitize(currentRemoteVersion),
            currentVersion: sanitize(currentLocalVersion),
            isVersionLower: isVersionLower(
              currentLocalVersion,
              currentRemoteVersion,
            ),
          ),
        ),
      );
    } catch (e, stackTrace) {
      if (e is! APIErrorResponse) {
        logError(e, stackTrace);
      }

      final APIErrorResponse error = translateError(e);

      emit(
        FetchLatestVersionFailed(
          message: error.message,
          errorCode: error.errorCode,
        ),
      );
    }
  }
}
