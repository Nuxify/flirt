import 'package:flirt/core/module/settings/service/settings_cubit.dart';
import 'package:flirt/gen/assets.gen.dart';
import 'package:flirt/internal/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpgradeDialog extends StatefulWidget {
  const ForceUpgradeDialog({
    required this.child,
    required this.onValidate,
    super.key,
  });
  final Widget child;
  final VoidCallback onValidate;

  @override
  State<ForceUpgradeDialog> createState() => _ForceUpgradeDialogState();
}

class _ForceUpgradeDialogState extends State<ForceUpgradeDialog> {
  void showUpdateRequiredDialog({
    required String currentVersion,
    required String latestVersion,
    required String launchStoreUrl,
  }) => showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text(
            'Update Required',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white,
          content: RichText(
            textDirection: TextDirection.ltr,
            text: TextSpan(
              children: <InlineSpan>[
                const TextSpan(
                  text: 'You’re currently using version ',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                TextSpan(
                  text: currentVersion,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(
                  text: ' but the latest required version is ',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                TextSpan(
                  text: '$latestVersion.\n\n',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(
                  text:
                      'To get the latest features and fixes, please update to the latest version',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => launchUrl(
                Uri.parse(launchStoreUrl),
                mode: LaunchMode.externalApplication,
              ),
              child: const Text(
                'Update Now',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  @override
  void initState() {
    super.initState();

    // FIXME: Integrate force upgrade feature (needs settings endpoint to cross-check latest version)
    // context.read<SettingsCubit>().fetchLatestVersion();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<SettingsCubit, SettingsState>(
        listenWhen: (SettingsState previous, SettingsState current) =>
            current is FetchLatestVersionSuccess ||
            current is FetchLatestVersionFailed,
        listener: (BuildContext context, SettingsState state) {
          if (state is FetchLatestVersionSuccess &&
              state.remoteConfig.isVersionLower) {
            FlutterNativeSplash.remove();
            showUpdateRequiredDialog(
              currentVersion: state.remoteConfig.currentVersion,
              latestVersion: state.remoteConfig.minimumRequiredVersion,
              launchStoreUrl: state.remoteConfig.storeUrl,
            );
            return;
          } else if (state is FetchLatestVersionFailed) {
            showSnackbar(context, isSuccessful: false, message: state.message);
          }

          /// On version is not required, call validate screen
          widget.onValidate.call();
        },
        buildWhen: (SettingsState previous, SettingsState current) =>
            current is FetchLatestVersionSuccess ||
            current is FetchLatestVersionFailed,
        builder: (BuildContext context, SettingsState state) {
          if (state is FetchLatestVersionSuccess &&
              state.remoteConfig.isVersionLower) {
            return Scaffold(
              body: Center(
                child: Assets.images.logo.image(width: 100, height: 100),
              ),
            );
          }

          return widget.child;
        },
      );
}
