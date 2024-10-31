import 'package:flirt/core/application/service/cubit/quote_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          HomeState(
            data: QuoteStateDTO(
              authors: <String>[],
              quotes: <QuoteResponseDTO>[],
            ),
          ),
        );

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
}
