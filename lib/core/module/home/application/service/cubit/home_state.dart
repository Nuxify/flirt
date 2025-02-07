part of 'home_cubit.dart';

class HomeState {
  HomeState({
    required this.data,
  });

  final QuoteStateDTO data;
}

class FetchQuoteLoading extends HomeState {
  FetchQuoteLoading({required super.data});
}

class FetchQuoteSuccess extends HomeState {
  FetchQuoteSuccess(this.quoteResponse, {required super.data});

  final QuoteResponseDTO quoteResponse;
}

class FetchQuoteFailed extends HomeState {
  FetchQuoteFailed({
    required this.errorCode,
    required this.message,
    required super.data,
  });

  final String errorCode;
  final String message;
}
