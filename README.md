# Flirt

Flutter Template for Building Amazing Mobile Apps

An article explaining the deeper intricacies of the template can be found here: https://nuxify.tech/blog/modular-flutter-template-with-state-management

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

3. Run the command `make` on the Terminal. This will automatically run a sequence of commands such as `make install` that are necessary for running the project.

4. Voila! The project should now be running on your designated simulator/device.

To use Flutter debug tools, go to Run -> Start Debugging in VS Code.

See Makefile for other commands.

Made with ❤️ at [Nuxify](https://nuxify.tech)
