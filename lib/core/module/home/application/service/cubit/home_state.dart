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

class FetchQuoteOnceLoading extends HomeState {
  FetchQuoteOnceLoading({required super.data});
}

class FetchQuoteOnceSuccess extends HomeState {
  FetchQuoteOnceSuccess(this.quoteResponse, {required super.data});

  final QuoteResponseDTO quoteResponse;
}

class FetchQuoteOnceFailed extends HomeState {
  FetchQuoteOnceFailed({required this.message, required super.data});

  final String message;
}
