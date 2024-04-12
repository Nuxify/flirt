import 'package:flirt/domain/models/api_response.dart';
import 'package:flirt/domain/models/quote/quote_response.dart';
import 'package:flirt/domain/repository/quote_repository.dart';
import 'package:flirt/module/home/application/service/cubit/home_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.quoteRepository})
      : super(
          HomeState(
            data: QuoteStateDTO(
              authors: <String>[],
              quotes: <QuoteResponseDTO>[],
            ),
          ),
        );

  final IQuoteRepository quoteRepository;

  /// Get Quote
  Future<void> fetchQuote() async {
    try {
      /// Persist data inside state by emitting the default value of state. If not, it will override the value.
      emit(FetchQuoteLoading(state.data));

      final QuoteResponse response = await quoteRepository.fetchQuote();
      final QuoteResponseDTO quote = QuoteResponseDTO(
        id: response.id,
        author: response.author,
        content: response.content,
      );

      /// Appending new value inside the list of the properties of DTO.
      state.data.quotes.add(quote);
      state.data.authors.add(quote.author);

      // emit FetchQuoteSuccess event
      // this set `quotes` in base class and emits an event
      emit(FetchQuoteSuccess(state.data, quote));

      /// This approach is used to demonstrate persistent data storing that you might use on cases where you need to hold data for a series of screens in a module.
      /// For example: If you separate a lengthy registration form in to 5 separate screens, you would need to hold that data until the last step.

      // If not for demonstration purposes, this approach should be using code below - emitting state directly.
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
