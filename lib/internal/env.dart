import 'package:flirt/core/domain/repository/secure_storage_repository.dart';
import 'package:flirt/internal/local_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Checks the environment configuration and returns the appropriate base URL.
///
/// This function checks the current environment configuration by reading the 'environment' key from secure storage.
/// If the environment is not 'production', it checks the 'API_ENV' environment variable. If neither of these is 'production',
/// it returns the base URL for the staging environment. Otherwise, it returns the base URL for the production environment.
///
/// [storage] The secure storage repository to use for reading environment configuration.
/// [apiStaging] The key for the staging environment base URL in the .env file. Defaults to 'STAGING_QUOTE_API'.
/// [apiProduction] The key for the production environment base URL in the .env file. Defaults to 'QUOTE_API'.
///
/// Returns the base URL for the current environment.
Future<String> checkEnvironment(
  ISecureStorageRepository storage, {
  String apiStaging = 'STAGING_API_URL',
  String apiProduction = 'API_URL',
}) async {
  String baseURL = dotenv.get(apiProduction);

  if (await storage.read(key: lsEnvironment) != 'production' &&
      dotenv.get('API_ENV') != 'production') {
    baseURL = dotenv.get(apiStaging);
  }

  return baseURL;
}
