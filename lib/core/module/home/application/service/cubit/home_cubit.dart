import 'package:flirt/core/domain/models/api_error_response.dart';
import 'package:flirt/core/domain/models/api_response.dart';
import 'package:flirt/core/domain/models/quote/quote_response.dart';
import 'package:flirt/core/domain/repository/quote_repository.dart';
import 'package:flirt/core/module/home/application/service/cubit/home_dto.dart';
import 'package:flirt/internal/utils.dart';
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

      final APIListResponse<QuoteResponse> response =
          await quoteRepository.fetchQuote();
      final QuoteResponseDTO quote = QuoteResponseDTO(
        author: response.data.first.author,
        content: response.data.first.quote,
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
    } on APIErrorResponse catch (error) {
      emit(
        FetchQuoteFailed(
          errorCode: error.errorCode!,
          message: error.message,
          data: state.data,
        ),
      );
    } catch (e, stackTrace) {
      logError(e, stackTrace);

      emit(
        FetchQuoteFailed(
          errorCode: '$e',
          message: 'Something went wrong.',
          data: state.data,
        ),
      );
    }
  }
}
