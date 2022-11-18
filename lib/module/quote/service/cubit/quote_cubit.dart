import 'package:flirt/infrastructures/api/api_response.dart';
import 'package:flirt/module/quote/models/quote_response.dart';
import 'package:flirt/module/quote/repository/quote_repository.dart';
import 'package:flirt/module/quote/service/cubit/quote_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quote_state.dart';

/// Cubit for general Quote
class QuoteCubit extends Cubit<QuoteState> {
  QuoteCubit()
      : super(
          QuoteState(
            data: QuoteStateDTO(
              authors: <String>[],
              quotes: <QuoteResponseDTO>[],
            ),
          ),
        );

  final QuoteRepository _quoteRepository = QuoteRepository();

  /// Get Quote
  Future<void> fetchQuote() async {
    try {
      /// Persist data inside state by emitting the default value of state. If not, it will override the value.
      emit(FetchQuoteLoading(state.data));

      final QuoteResponse response = await _quoteRepository.fetchQuote();
      final QuoteResponseDTO quote = QuoteResponseDTO(
        id: response.id,
        author: response.author,
        en: response.en,
      );

      /// Appending new value inside the list of the properties of DTO.
      state.data.quotes.add(quote);
      state.data.authors.add(quote.author);

      // emit FetchQuoteSuccess event
      // this set `quotes` in base class and emits an event
      emit(FetchQuoteSuccess(state.data, quote));

      // TODO: If you want update the state directly, just emit the state with custom value
      // emit(QuoteState(data: QuoteStateDTO(quotes: <QuoteResponseDTO>[], authors: <String>[])));
    } catch (e) {
      final APIResponse<QuoteResponse> error = e as APIResponse<QuoteResponse>;
      emit(
        FetchQuoteFailed(
          state.data,
          errorCode: error.errorCode!,
          message: error.message,
        ),
      );
    }
  }
}
