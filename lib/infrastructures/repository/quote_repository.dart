import 'dart:convert';
import 'dart:io';
import 'package:flirt/infrastructures/models/api_response.dart';
import 'package:flirt/infrastructures/models/quote/quote_response.dart';
import 'package:flirt/infrastructures/repository/interfaces/quote_repository.dart';
import 'package:http/http.dart' as http;

class QuoteRepository implements IQuoteRepository {
  final String _baseURL = 'api.quotable.io';
  final String _quoteRepositoryURL = '/random';

  @override
  Future<QuoteResponse> fetchQuote() async {
    try {
      final http.Response response = await http.get(
        Uri.https(_baseURL, _quoteRepositoryURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final QuoteResponse result = QuoteResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
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
}
