import 'dart:convert';
import 'dart:io';
import 'package:flirt/core/domain/models/api_error_response.dart';
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

  /// This getter can be used to set the base URL based on the environment,
  /// if you are running a staging/production environment
  // Future<String> get _baseURL => checkEnvironment(_storage);

  @override
  Future<APIListResponse<QuoteResponse>> fetchQuote() async {
    final http.Response response;
    try {
      response = await http.get(
        Uri.https(_baseURL, _repositoryURL),
        headers: httpRequestHeaders,
      );

      if (response.statusCode < 200 || response.statusCode > 299) {
        if (response.statusCode == 401) {
          throw APIErrorResponse.unauthorizedErrorResponse();
        }

        throw APIErrorResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }

      final APIListResponse<QuoteResponse> result =
          APIListResponse<QuoteResponse>.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
        (Object? data) => QuoteResponse.fromJson(data! as Map<String, dynamic>),
      );
      
      return result;
    } on SocketException {
      throw APIErrorResponse.socketErrorResponse();
    } catch (e) {
      throw APIErrorResponse.typeCastingErrorResponse();
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
