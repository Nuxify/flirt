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

  /// This method is used to store a new quote and its author in the state.
  /// It appends the quote to the list of quotes and the author to the list of authors.
  ///
  /// [quote] Single response from the quote
  Future<void> storeState(QuoteResponseDTO quote) async {
    /// This approach is used to demonstrate persistent data storing that you might use on cases where you need to hold data for a series of screens in a module.
    /// For example: If you separate a lengthy registration form in to 5 separate screens, you would need to hold that data until the last step.
    state.data.quotes.add(quote);
    state.data.authors.add(quote.author);
  }

  /// Get Quote
  Future<void> fetchQuote() async {
    try {
      emit(FetchQuoteLoading(data: state.data));

      final APIListResponse<QuoteResponse> response =
          await quoteRepository.fetchQuote();

      final QuoteResponseDTO quote = QuoteResponseDTO(
        author: response.data.first.author,
        content: response.data.first.quote,
      );

      await storeState(quote);

      // emit FetchQuoteSuccess event
      // this set `quotes` in base class and emits an event
      emit(FetchQuoteSuccess(quote, data: state.data));
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
