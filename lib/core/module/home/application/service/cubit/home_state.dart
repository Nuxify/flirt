part of 'home_cubit.dart';

class HomeState {
  const HomeState({
    required this.data,
  });

  final QuoteStateDTO data;
}

class FetchQuoteLoading extends HomeState {
  FetchQuoteLoading(QuoteStateDTO data) : super(data: data);
}

class FetchQuoteSuccess extends HomeState {
  const FetchQuoteSuccess(QuoteStateDTO data, this.quoteResponse)
      : super(data: data);

  final QuoteResponseDTO quoteResponse;
}

class FetchQuoteFailed extends HomeState {
  const FetchQuoteFailed(
    QuoteStateDTO data, {
    required this.errorCode,
    required this.message,
  }) : super(data: data);

  final String errorCode;
  final String message;
}
