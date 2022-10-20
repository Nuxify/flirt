part of 'quote_cubit.dart';

class QuoteState {
  const QuoteState({this.quotes});

  final List<QuoteResponseDTO>? quotes;
}

class FetchQuoteLoading extends QuoteState {}

class FetchQuoteSuccess extends QuoteState {
  const FetchQuoteSuccess(this.quoteResponse) : super(quotes: quoteResponse);

  final List<QuoteResponseDTO> quoteResponse;
}

class FetchQuoteFailed extends QuoteState {
  const FetchQuoteFailed({
    required this.errorCode,
    required this.message,
  });

  final String errorCode;
  final String message;
}
