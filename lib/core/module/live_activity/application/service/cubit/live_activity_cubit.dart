import 'package:flirt/core/domain/models/api_error_response.dart';
import 'package:flirt/core/domain/models/api_response.dart';
import 'package:flirt/core/domain/models/quote/quote_response.dart';
import 'package:flirt/core/domain/repository/quote_repository.dart';
import 'package:flirt/core/module/home/application/service/cubit/home_dto.dart';
import 'package:flirt/internal/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'live_activity_state.dart';

class LiveActivityCubit extends Cubit<LiveActivityState> {
  LiveActivityCubit({required this.quoteRepository})
    : super(LiveActivityInitialState());
  final IQuoteRepository quoteRepository;

  /// Fetch a quote without emitting state changes (useful for one-off requests).
  Future<void> fetchQuoteOnce() async {
    try {
      emit(FetchQuoteOnceLoading());

      final APIListResponse<QuoteResponse> response = await quoteRepository
          .fetchQuote();

      final QuoteResponseDTO quote = QuoteResponseDTO(
        author: response.data.first.author,
        content: response.data.first.quote,
      );

      emit(FetchQuoteOnceSuccess(quote));
    } catch (e, stackTrace) {
      if (e is! APIErrorResponse) {
        logError(e, stackTrace);
      }

      final APIErrorResponse error = translateError(e);

      emit(
        FetchQuoteOnceFailed(
          errorCode: error.errorCode!,
          message: error.message,
        ),
      );
    }
  }
}
