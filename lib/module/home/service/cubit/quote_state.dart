part of 'quote_cubit.dart';

class QuoteState {
  const QuoteState({
    required this.data,
  });

  final QuoteStateDTO data;
}

/// Event Classes
class FetchQuoteLoading extends QuoteState {
  FetchQuoteLoading(QuoteStateDTO data) : super(data: data);
}

class FetchQuoteSuccess extends QuoteState {
  const FetchQuoteSuccess(QuoteStateDTO data, this.quoteResponse)
      : super(data: data);

  final QuoteResponseDTO quoteResponse;
}

class FetchQuoteFailed extends QuoteState {
  const FetchQuoteFailed(
    QuoteStateDTO data, {
    required this.errorCode,
    required this.message,
  }) : super(data: data);

  final String errorCode;
  final String message;
}
