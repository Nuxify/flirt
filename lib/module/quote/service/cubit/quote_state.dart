part of 'quote_cubit.dart';

class QuoteState {
  const QuoteState({
    this.quotes,
    this.authors,
  });

  final List<QuoteResponseDTO>? quotes;
  final List<String>? authors;
}

class QuoteInitial extends QuoteState {}

/// Event Classes
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
