import 'package:flirt/core/domain/models/api_response.dart';
import 'package:flirt/core/domain/models/quote/quote_response.dart';

abstract class IQuoteRepository {
  /// Fetches a random quote from the API.
  ///
  /// This method sends a GET request to the quote API to fetch a random quote.
  /// It returns a [APIListResponse] containing a list of [QuoteResponse] objects.
  /// If the request fails or the response is not successful, it throws an [APIErrorResponse].
  Future<APIListResponse<QuoteResponse>> fetchQuote();
}
