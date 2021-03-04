# Flirt
Flutter Template for Building Amazing Mobile Apps

## Example

This app is a basic QR generator and scanner where the user:
- can generate QR code with optional ID and custom data
- scan the genereted QR code and display the decoded message to user
## Build steps

All these steps are assuming you're using VS Code as your editor.

1. Make sure that the [Flutter SDK](https://flutter.dev/docs/get-started/install) is installed on your machine. 
- The installation of the SDK requires plenty of other software such as **Android Studio** and **Xcode** (if you're developing in Mac). Ensure that you have these too.

2. You can run the project in multiple ways:
- Android Emulator (Open Android Studio -> Configure -> AVD Manager)
- iOS Simulator (Run ```open -a Simulator``` in the Terminal)
- Physical device (Connect phone to your development machine)

3. Run the command ``make`` on the Terminal. This will automatically run a sequence of commands such as ```make install``` that are necessary for running the project.

4. Voila! The project should now be running on your designated simulator/device.

To use Flutter debug tools, go to Run -> Start Debugging in VS Code.

See Makefile for other commands.
## Roadmap

- Using Dio as HTTP client (for study)
- Test Driven Development (TDD) approach

Made with ❤️ at [Nuxify](https://nuxify.tech)