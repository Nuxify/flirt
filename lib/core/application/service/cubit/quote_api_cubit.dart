import 'package:flirt/core/application/service/cubit/quote_dto.dart';
import 'package:flirt/core/domain/models/api_error_response.dart';
import 'package:flirt/core/domain/models/api_response.dart';
import 'package:flirt/core/domain/models/quote/quote_response.dart';
import 'package:flirt/core/domain/repository/quote_repository.dart';
import 'package:flirt/internal/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quote_api_state.dart';

class QuoteAPICubit extends Cubit<QuoteAPIState> {
  QuoteAPICubit({required this.quoteRepository}) : super(QuoteAPIState());
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
