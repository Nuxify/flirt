import 'package:flirt/core/domain/models/api_error_response.dart';
import 'package:flirt/core/domain/models/api_response.dart';
import 'package:flirt/core/domain/models/quote/quote_response.dart';
import 'package:flirt/core/domain/repository/quote_repository.dart';
import 'package:flirt/core/module/home/application/service/cubit/home_dto.dart';
import 'package:flirt/internal/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_api_state.dart';

class HomeAPICubit extends Cubit<HomeAPIState> {
  HomeAPICubit({required this.quoteRepository}) : super(HomeAPIState());
  final IQuoteRepository quoteRepository;

  /// Get Quote
  Future<void> fetchQuote() async {
    try {
      emit(FetchQuoteLoading());

      final APIListResponse<QuoteResponse> response =
          await quoteRepository.fetchQuote();

      final QuoteResponseDTO quote = QuoteResponseDTO(
        author: response.data.first.author,
        content: response.data.first.quote,
      );

      // emit FetchQuoteSuccess event
      // this set `quotes` in base class and emits an event
      emit(FetchQuoteSuccess(quote));
    } on APIErrorResponse catch (error) {
      emit(
        FetchQuoteFailed(
          errorCode: error.errorCode!,
          message: error.message,
        ),
      );
    } catch (e, stackTrace) {
      logError(e, stackTrace);

      emit(
        FetchQuoteFailed(
          errorCode: '$e',
          message: 'Something went wrong.',
        ),
      );
    }
  }
}
