# Flirt

Flutter Template for Building Amazing Mobile Apps

This template is inspired by the Domain-Driven Design (DDD) pattern.

## Demo

Download the Flirt demo app from Google Play Store: https://play.google.com/store/apps/details?id=com.nuxify.flirt

Coming soon in Apple App Store.

## Flutter Version Manager (FVM)

We recommend using FVM to manage Flutter versions as you may switch from different Flutter versions depending on the projects compatibility. Follow the guide here: https://fvm.app/documentation/getting-started/installation

## Build steps

All these steps are assuming you're using VS Code as your editor.

1. Make sure that the [Flutter SDK](https://flutter.dev/docs/get-started/install) is installed on your machine.

- The installation of the SDK requires plenty of other software such as **Android Studio** and **Xcode** (if you're developing in Mac). Ensure that you have these too.

2. You can run the project in multiple ways:

- Android Emulator (Open Android Studio -> Configure -> AVD Manager)
- iOS Simulator (Run `open -a Simulator` in the Terminal)
- Physical device (Connect phone to your development machine)

3. Run the command `make compile` on the Terminal. This will automatically run a sequence of commands that are necessary for running the project.

4. Create a .env file in the root of the folder, copy the contents of .env.example and fill it with the corresponding data. 

5. Voila! The project should now be running on your designated simulator/device.

To use Flutter debug tools, go to Run -> Start Debugging in VS Code.

See Makefile for other commands.

## Error Codes

The following table documents the standard error codes used across the project, their keys, and a short description or suggested action.

| Code | Key | Description | Notes |
|------|-----|-------------|-------|
| `ERR-DAT-1` | `apiParseError` | TypeError or FormatException while parsing API response | Check API response shape and parsing logic |
| `ERR-NET-1` | `serverError` | Server error returned by backend | HTTP 500/503 — backend may be crashing |
| `ERR-NET-2` | `timeout` | Connection timeout | Check network connectivity; retry or increase timeout |
| `ERR-NET-3` | (socket exception) | Socket exception occurred | Verify internet connection and socket handling |
| `ERR-AUTH-1` | `unauthenticated` | Unauthenticated request | HTTP 401 — token expired or invalid; re-authenticate |

Made with ❤️ at [Nuxify](https://nuxify.tech)

## Live Activities

- **Overview:** Live Activities let iOS surface ongoing app state on the Lock Screen and Dynamic Island. Android does not have an exact ActivityKit equivalent — the recommended cross-platform approach is to implement a persistent ongoing UI: ActivityKit on iOS, and an ongoing foreground notification or foreground service on Android. This project includes a demo service to create, update, and end Live Activities on iOS and guidance for the Android equivalent.

- **Requirements:**
  - **iOS:** Device running iOS 16.1+ for Live Activities; iOS 17.2+ for push-to-start tokens. Physical iPhone recommended (Dynamic Island visible on iPhone 14 Pro and later). Simulators may not reliably show Live Activities.
  - **Android:** Device running Android (any recent API) — for persistent notifications or foreground services. Use a physical device or emulator for testing notifications. If you use native foreground services, ensure your app requests and holds the required foreground-service permissions.
  - **Signing (iOS):** App and Widget extension must be signed with provisioning profiles that include the App Group and Push capabilities. Ensure the App Group `group.com.nuxify.flirttemplate` is registered in your Apple Developer account and added to both targets.

- **Files to inspect / tweak:**
  - **Service:** `lib/core/domain/live_activities_service.dart` — central API used by the app to manage activities. See [lib/core/domain/live_activities_service.dart](lib/core/domain/live_activities_service.dart#L1-L400).
  - **Widget UI (iOS):** `ios/FlirtAppWidget/FlirtAppWidgetLiveActivity.swift` — lock-screen/Dynamic Island layout and images. See [ios/FlirtAppWidget/FlirtAppWidgetLiveActivity.swift](ios/FlirtAppWidget/FlirtAppWidgetLiveActivity.swift#L1-L240).
  - **Android notifications:** consider `flutter_local_notifications` usage in Dart and native foreground service classes under `android/app/src/main/...` if needed.

- **How to create a Live Activity (Flutter — iOS):**

  1. Build a payload with an `activityId` (unique notification id) and the fields expected by the widget. Example payload used in the demo:

```dart
final Map<String, dynamic> payload = {
  'activityId': notificationId,
  'bookTitle': 'The Great Gatsby',
  'author': 'F. Scott Fitzgerald',
  'coverUrl': 'https://picsum.photos/seed/gatsby/200/300',
  'page': 1,
};

final bool ok = await LiveActivitiesService.instance.startLiveActivity(payload);
```

  - **Result:** `startLiveActivity` returns `true` when the native plugin created the activity successfully and the activity id was recorded.

- **How to update a Live Activity (iOS):**

```dart
await LiveActivitiesService.instance.updateActivity(
  activityId: '<native-activity-id>',
  data: {'page': 42,
  'bookTitle': 'The Great Gatsby',
  'author': 'F. Scott Fitzgerald',},
);
```

  - The plugin sends the update into the running Activity; the widget reads updated content (via App Group UserDefaults in this project) and refreshes the UI.

- **How to end a Live Activity (iOS):**

```dart
await LiveActivitiesService.instance.endActivityById('<native-activity-id>');
// or by notification id (the original `activityId` you passed):
await LiveActivitiesService.instance.endActivityByNotificationId('<your-notification-id>');
```

- **App Group & Entitlements checklist (iOS):**
  - Register `group.com.nuxify.flirttemplate` in Apple Developer and add it to both the main app and the widget extension entitlements files: [ios/Runner/Runner.entitlements](ios/Runner/Runner.entitlements#L1-L40) and [ios/FlirtAppWidget/FlirtAppWidgetExtension.entitlements](ios/FlirtAppWidget/FlirtAppWidgetExtension.entitlements#L1-L40).
  - Ensure `NSSupportsLiveActivities` is present and set to `true` in `Info.plist` for the app and widget where applicable: [ios/Runner/Info.plist](ios/Runner/Info.plist#L1-L60), [ios/FlirtAppWidget/Info.plist](ios/FlirtAppWidget/Info.plist#L1-L40).
  - Make sure `aps-environment` (push) is set in entitlements if you plan to use remote updates.

- **Testing tips:**
  - Use a physical iPhone on iOS 16.1+ to verify Lock Screen Live Activities. For Dynamic Island verify on iPhone models that support it.
  - For Android verify ongoing notifications on a physical device or emulator.
  - Watch Flutter logs for helpful debug prints from `LiveActivitiesService` (they include `createActivity returned id=...` and `Live Activity became active: ...`). Use Xcode's device console for ActivityKit-native logs and `adb logcat` for Android native logs.
  - If the Live Activity doesn't appear: confirm app and extension signing, App Group presence, and that `areActivitiesSupported()`/`areActivitiesEnabled()` return true in logs (iOS).

- **Troubleshooting & common issues:**
  - **Activity created but not visible (iOS):** often caused by missing App Group, wrong provisioning, or running on an unsupported simulator.

