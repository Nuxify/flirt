part of 'settings_cubit.dart';

class SettingsState {}

class ForceUpgradeInitial extends SettingsState {}

class FetchLatestVersionLoading extends SettingsState {}

class FetchLatestVersionSuccess extends SettingsState {
  FetchLatestVersionSuccess({required this.remoteConfig});

  final RemoteConfigDTO remoteConfig;
}

class FetchLatestVersionFailed extends SettingsState {
  FetchLatestVersionFailed({required this.message, this.errorCode});

  final String? errorCode;
  final String message;
}
