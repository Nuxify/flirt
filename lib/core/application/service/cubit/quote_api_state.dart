part of 'quote_api_cubit.dart';

class QuoteAPIState {
  const QuoteAPIState({
    required this.data,
  });

  final QuoteStateDTO data;
}

class FetchQuoteLoading extends QuoteAPIState {
  FetchQuoteLoading(QuoteStateDTO data) : super(data: data);
}

class FetchQuoteSuccess extends QuoteAPIState {
  const FetchQuoteSuccess(QuoteStateDTO data, this.quoteResponse)
      : super(data: data);

  final QuoteResponseDTO quoteResponse;
}

class FetchQuoteFailed extends QuoteAPIState {
  const FetchQuoteFailed({
    required this.errorCode,
    required this.message,
    required super.data,
  });

  final String errorCode;
  final String message;
}
