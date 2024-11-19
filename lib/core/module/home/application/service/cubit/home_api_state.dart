part of 'home_api_cubit.dart';

class HomeAPIState {}

class FetchQuoteLoading extends HomeAPIState {}

class FetchQuoteSuccess extends HomeAPIState {
  FetchQuoteSuccess(this.quoteResponse);

  final QuoteResponseDTO quoteResponse;
}

class FetchQuoteFailed extends HomeAPIState {
  FetchQuoteFailed({
    required this.errorCode,
    required this.message,
  });

  final String errorCode;
  final String message;
}
