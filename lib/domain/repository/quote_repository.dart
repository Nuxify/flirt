import 'package:flirt/domain/models/quote/quote_response.dart';

abstract class IQuoteRepository {
  Future<QuoteResponse> fetchQuote();
}
