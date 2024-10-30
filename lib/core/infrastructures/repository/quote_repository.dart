import 'dart:convert';
import 'dart:io';

import 'package:flirt/core/domain/models/api_error_response.dart';
import 'package:flirt/core/domain/models/api_response.dart';
import 'package:flirt/core/domain/models/quote/quote_response.dart';
import 'package:flirt/core/domain/repository/quote_repository.dart';
import 'package:flirt/core/domain/repository/secure_storage_repository.dart';
import 'package:flirt/core/infrastructures/repository/secure_storage_repository.dart';
import 'package:flirt/internal/api.dart';
import 'package:flirt/internal/env.dart';
import 'package:http/http.dart' as http;

class QuoteRepository implements IQuoteRepository {
  final ISecureStorageRepository _storage = SecureStorageRepository();

  final String _repositoryURL = '/api/v1/flirt/quote/random';

  /// This getter can be used to set the base URL based on the environment,
  /// if you are running a staging/production environment
  Future<String> get _baseURL => checkEnvironment(_storage);

  @override
  Future<APIListResponse<QuoteResponse>> fetchQuote() async {
    http.Response? response;

    try {
      response = await http.get(
        Uri.https(await _baseURL, _repositoryURL),
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
      if (e is APIErrorResponse) rethrow;

      throw APIErrorResponse.typeCastingErrorResponse();
    }
  }
}
