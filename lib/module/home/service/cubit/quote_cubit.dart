import 'package:flirt/infrastructures/repository/interface/quote_repository.dart';
import 'package:flirt/module/home/service/cubit/quote_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quote_state.dart';

/// Cubit for general Quote
class QuoteCubit extends Cubit<QuoteState> {
  QuoteCubit({required this.quoteRepository}) : super(QuoteInitial());
  final IQuoteRepository quoteRepository;

  /// Get Quote
  Future<void> fetchQuote() async {
    try {
      // emit(FetchQuoteLoading());
      // final QuoteResponse response = await quoteRepository.fetchQuote();
      // emit(
      //   FetchQuoteSuccess(
      //     QuoteResponseDTO(
      //       id: response.id,
      //       author: response.author,
      //       en: response.en,
      //     ),
      //   ),
      // );
    } catch (e) {
      // final APIResponse<QuoteResponse> error = e as APIResponse<QuoteResponse>;
      // emit(
      //   FetchQuoteFailed(errorCode: error.errorCode!, message: error.message),
      // );
    }
  }
}
