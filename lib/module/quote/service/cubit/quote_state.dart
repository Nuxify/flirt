part of 'quote_cubit.dart';

@immutable
abstract class QuoteState {
  const QuoteState();
}

class QuoteInitial extends QuoteState {}

class FetchQuoteLoading extends QuoteState {}

class FetchQuoteSuccess extends QuoteState {
  const FetchQuoteSuccess(this.quoteResponse);
  final QuoteResponseDTO quoteResponse;
}

class FetchQuoteFailed extends QuoteState {
  const FetchQuoteFailed({
    required this.errorCode,
    required this.message,
  });

  final String errorCode;
  final String message;
}
