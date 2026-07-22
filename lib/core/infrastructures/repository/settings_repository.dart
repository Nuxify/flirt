import 'dart:convert';
import 'dart:io';

import 'package:flirt/core/domain/models/api_error_response.dart';
import 'package:flirt/core/domain/models/api_response.dart';
import 'package:flirt/core/domain/models/settings/settings_response.dart';
import 'package:flirt/core/domain/repository/secure_storage_repository.dart';
import 'package:flirt/core/domain/repository/settings_repository.dart';
import 'package:flirt/core/infrastructures/repository/secure_storage_repository.dart';
import 'package:flirt/internal/env.dart';
import 'package:http/http.dart' as http;

class SettingsRepository implements ISettingsRepository {
  final ISecureStorageRepository _storage = SecureStorageRepository();
  final String _remoteConfigURL = '/api/v1/setting/remote-config';

  Future<String> get _baseURL => checkEnvironment(_storage);

  @override
  Future<APIResponse<RemoteConfigResponse>> fetchLatestVersion(
    String remoteConfigId,
  ) async {
    try {
      final http.Response response = await http.get(
        Uri.https(await _baseURL, '$_remoteConfigURL/$remoteConfigId'),
      );

      final Map<String, dynamic> responseMap =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      if (response.statusCode < 200 || response.statusCode > 299) {
        if (response.statusCode == 401) {
          throw APIErrorResponse.unauthorizedErrorResponse();
        }

        final APIErrorResponse apiErrorResponse = APIErrorResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );

        throw apiErrorResponse;
      }

      final APIResponse<RemoteConfigResponse> result =
          APIResponse<RemoteConfigResponse>.fromJson(
            responseMap,
            (Object? data) =>
                RemoteConfigResponse.fromJson(data! as Map<String, dynamic>),
          );

      return result;
    } on SocketException {
      throw APIErrorResponse.socketErrorResponse();
    } on http.ClientException {
      throw APIErrorResponse.socketErrorResponse();
    } catch (e) {
      if (e is APIErrorResponse) rethrow;

      throw APIErrorResponse.typeCastingErrorResponse();
    }
  }
}
