import 'package:flirt/core/domain/models/api_response.dart';
import 'package:flirt/core/domain/models/settings/settings_response.dart';

abstract class ISettingsRepository {
  /// Fetch latest version of the app
  Future<APIResponse<RemoteConfigResponse>> fetchLatestVersion(
    String remoteConfigId,
  );
}
