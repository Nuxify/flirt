import 'dart:convert';
import 'dart:io';
import 'package:flirt/core/domain/models/api_response.dart';
import 'package:flirt/core/domain/models/quote/quote_response.dart';
import 'package:flirt/core/domain/repository/quote_repository.dart';
import 'package:flirt/internal/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class QuoteRepository implements IQuoteRepository {
  // final ISecureStorageRepository _storage = SecureStorageRepository();

  final String _baseURL = dotenv.get('API_ENV') != 'production'
      ? dotenv.get('QUOTE_API')
      : dotenv.get('STAGING_QUOTE_API');
  final String _repositoryURL = '/api/v1/flirt/quote/random';

  /// This function can be used to set the base URL based on the environment,
  /// if you are running a staging/production environment
  ///
  // @override
  // Future<void> checkEnvironment() async {
  //   if (await _storage.read(key: lsEnvironment) != 'production' &&
  //       dotenv.get('API_ENV') != 'production') {
  //     _baseURL = dotenv.get('STAGING_APP_API');
  //   } else {
  //     _baseURL = dotenv.get('APP_API');
  //   }
  // }

  @override
  Future<APIListResponse<QuoteResponse>> fetchQuote() async {
    try {
      final http.Response response = await http.get(
        Uri.https(_baseURL, _repositoryURL),
        headers: httpRequestHeaders,
      );

      final APIListResponse<QuoteResponse> result =
          APIListResponse<QuoteResponse>.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
        (Object? data) => QuoteResponse.fromJson(data! as Map<String, dynamic>),
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return result;
      }

      throw result;
    } on SocketException {
      final QuoteResponse error =
          QuoteResponse.fromJson(APIResponse.socketErrorResponse());
      throw error;
    }
  }

  /// This function can be used alternatively if you have control over how the API response is structured.
  ///
  /// The `APIResponse` object would act as the base object for all responses.
  ///
  /// The `APIErrorResponse` object would act as the base object for all error responses.
  ///
  /// Due to Dart being a strictly-typed language, it is recommended to use these base objects so that
  /// we have a base level of predictability on the responses and we are able to manipulate the UI accordingly.
  ///
  // @override
  // Future<APIResponse<LoginResponse>> login(LoginRequest data) async {
  //   await checkEnvironment();
  //   try {
  //     final http.Response response = await http.post(
  //       Uri.https(
  //         _baseURL,
  //         '$_repositoryURL/login',
  //       ),
  //       body: jsonEncode(data),
  //     );
  //     final String responseBody = utf8.decode(response.bodyBytes);

  //     // Check if response contains an error key in the JSON response
  //     if ((jsonDecode(responseBody) as Map<String, dynamic>)['errorCode'] !=
  //         null) {
  //       final APIErrorResponse<dynamic> result =
  //           APIErrorResponse<dynamic>.fromJson(
  //         jsonDecode(responseBody) as Map<String, dynamic>,
  //         (_) {},
  //       );

  //       throw result;
  //     }

  //     final APIResponse<LoginResponse> result =
  //         APIResponse<LoginResponse>.fromJson(
  //       jsonDecode(responseBody) as Map<String, dynamic>,
  //       (Object? data) => LoginResponse.fromJson(data! as Map<String, dynamic>),
  //     );

  //     return result;
  //   } on SocketException {
  //     throw APIErrorResponse.socketErrorResponse();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
