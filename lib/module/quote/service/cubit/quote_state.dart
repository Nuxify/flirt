part of 'quote_cubit.dart';

@immutable
abstract class QuoteState<T> {
  const QuoteState(this.state);
  final T? state;
}

class QuoteInitial<T> extends QuoteState<T> {
  const QuoteInitial({T? state}) : super(state);
}

class FetchQuoteLoading<T> extends QuoteState<T> {
  const FetchQuoteLoading({T? state}) : super(state);
}

class FetchQuoteSuccess<T> extends QuoteState<T> {
  const FetchQuoteSuccess(this.quoteResponse, {T? state}) : super(state);
  final QuoteResponseDTO quoteResponse;
}

class FetchQuoteFailed<T> extends QuoteState<T> {
  const FetchQuoteFailed({
    required this.errorCode,
    required this.message,
    T? state,
  }) : super(state);

  final String errorCode;
  final String message;
}
