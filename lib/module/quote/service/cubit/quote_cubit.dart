import 'package:flirt/infrastructures/api/api_response.dart';
import 'package:flirt/module/quote/models/quote_response.dart';
import 'package:flirt/module/quote/repository/quote_repository.dart';
import 'package:flirt/module/quote/service/cubit/quote_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quote_state.dart';

/// Cubit for general Quote
class QuoteCubit extends Cubit<QuoteState> {
  QuoteCubit(QuoteState initialState) : super(initialState);

  final QuoteRepository _quoteRepository = QuoteRepository();

  /// Get Quote
  Future<void> fetchQuote() async {
    try {
      emit(FetchQuoteLoading());

      // get latest quotes
      final List<QuoteResponseDTO> quotes =
          state.quotes ?? <QuoteResponseDTO>[];
      // get latest authors
      final List<String> authors = state.authors ?? <String>[];

      final QuoteResponse response = await _quoteRepository.fetchQuote();
      final QuoteResponseDTO quote = QuoteResponseDTO(
        id: response.id,
        author: response.author,
        en: response.en,
      );

      quotes.add(quote);
      authors.add(quote.author);

      // emit FetchQuoteSuccess event
      // this set `quotes` in base class and emits an event
      emit(FetchQuoteSuccess(quotes));

      // set quote authors
      // this set `authors` directly from base class
      emit(QuoteState(authors: authors));
    } catch (e) {
      final APIResponse<QuoteResponse> error = e as APIResponse<QuoteResponse>;
      emit(
        FetchQuoteFailed(
          errorCode: error.errorCode!,
          message: error.message,
        ),
      );
    }
  }
}
