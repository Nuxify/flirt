import 'package:flirt/core/domain/repository/secure_storage_repository.dart';
import 'package:flirt/internal/local_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> checkEnvironment(
  ISecureStorageRepository storage, {
  String apiStaging = 'STAGING_QUOTE_API',
  String apiProduction = 'QUOTE_API',
}) async {
  String baseURL = dotenv.get(apiProduction);

  if (await storage.read(key: lsEnvironment) != 'production' &&
      dotenv.get('API_ENV') != 'production') {
    baseURL = dotenv.get(apiStaging);
  }

  return baseURL;
}
