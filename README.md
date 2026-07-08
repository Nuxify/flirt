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
