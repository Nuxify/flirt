import 'package:flirt/infrastructures/api/api_response.dart';
import 'package:flirt/module/quote/models/quote_response.dart';
import 'package:flirt/module/quote/repository/quote_repository.dart';
import 'package:flirt/module/quote/service/cubit/quote_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quote_state.dart';

/// Cubit for general Quote
class QuoteCubit extends Cubit<QuoteState<dynamic>> {
  QuoteCubit() : super(const QuoteInitial<QuoteState<dynamic>>());

  final QuoteRepository _quoteRepository = QuoteRepository();

  /// Get Quote
  Future<void> fetchQuote() async {
    /// If the initial state value of state is null, we want to save List of QuoteResponseDTO withen this function.
    /// Initialize an empty List of QuoteResponseDTO, if not null then reuse the list and just append new object.
    final List<QuoteResponseDTO> prevState = state.state != null
        ? state.state as List<QuoteResponseDTO>
        : <QuoteResponseDTO>[];
    try {
      emit(FetchQuoteLoading<List<QuoteResponseDTO>>(state: prevState));

      final QuoteResponse response = await _quoteRepository.fetchQuote();
      final QuoteResponseDTO data = QuoteResponseDTO(
        id: response.id,
        author: response.author,
        en: response.en,
      );
      prevState.add(data);

      emit(
        FetchQuoteSuccess<List<QuoteResponseDTO>>(
          data,
          state: prevState,
        ),
      );
    } catch (e) {
      final APIResponse<QuoteResponse> error = e as APIResponse<QuoteResponse>;
      emit(
        FetchQuoteFailed<List<QuoteResponseDTO>>(
          errorCode: error.errorCode!,
          message: error.message,
          state: prevState,
        ),
      );
    }
  }
}
