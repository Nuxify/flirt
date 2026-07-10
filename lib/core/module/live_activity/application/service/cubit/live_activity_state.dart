part of 'live_activity_cubit.dart';

class LiveActivityState {}

class LiveActivityInitialState extends LiveActivityState {}

class FetchQuoteOnceLoading extends LiveActivityState {}

class FetchQuoteOnceSuccess extends LiveActivityState {
  FetchQuoteOnceSuccess(this.quoteResponse);

  final QuoteResponseDTO quoteResponse;
}

class FetchQuoteOnceFailed extends LiveActivityState {
  FetchQuoteOnceFailed({required this.errorCode, required this.message});

  final String message;
  final String errorCode;
}
