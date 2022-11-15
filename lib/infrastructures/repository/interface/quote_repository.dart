import 'package:flirt/infrastructures/models/quote/quote_response.dart';

abstract class IQuoteRepository {
  Future<QuoteResponse> fetchQuote();
}
