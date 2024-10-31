part of 'quote_api_cubit.dart';

class QuoteAPIState {}

class FetchQuoteLoading extends QuoteAPIState {}

class FetchQuoteSuccess extends QuoteAPIState {
  FetchQuoteSuccess(this.quoteResponse);

  final QuoteResponseDTO quoteResponse;
}

class FetchQuoteFailed extends QuoteAPIState {
  FetchQuoteFailed({
    required this.errorCode,
    required this.message,
  });

  final String errorCode;
  final String message;
}
