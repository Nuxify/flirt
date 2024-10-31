part of 'quote_api_cubit.dart';

class QuoteApiState {
  const QuoteApiState({
    required this.data,
  });

  final QuoteStateDTO data;
}

class FetchQuoteLoading extends QuoteApiState {
  FetchQuoteLoading(QuoteStateDTO data) : super(data: data);
}

class FetchQuoteSuccess extends QuoteApiState {
  const FetchQuoteSuccess(QuoteStateDTO data, this.quoteResponse)
      : super(data: data);

  final QuoteResponseDTO quoteResponse;
}

class FetchQuoteFailed extends QuoteApiState {
  const FetchQuoteFailed({
    required this.errorCode,
    required this.message,
    required super.data,
  });

  final String errorCode;
  final String message;
}
