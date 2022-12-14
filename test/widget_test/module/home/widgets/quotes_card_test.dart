import 'package:bloc_test/bloc_test.dart';
import 'package:flirt/module/home/interfaces/widgets/quotes_card.dart';
import 'package:flirt/module/home/service/cubit/quote_cubit.dart';
import 'package:flirt/module/home/service/cubit/quote_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shimmer/shimmer.dart';

class MockQuoteCubit extends MockCubit<QuoteState> implements QuoteCubit {}

void main() {
  late MockQuoteCubit mockQuoteCubit;

  setUp(() {
    mockQuoteCubit = MockQuoteCubit();
  });

  Future<void> pumpWidget(WidgetTester tester) async => tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<QuoteCubit>(
            create: (BuildContext context) => mockQuoteCubit,
            child: const Scaffold(
              body: QuotesCard(),
            ),
          ),
        ),
      );

  void listenStub() {
    when(() => mockQuoteCubit.state).thenReturn(
      QuoteState(
        data: QuoteStateDTO(authors: <String>[], quotes: <QuoteResponseDTO>[]),
      ),
    );
    when(() => mockQuoteCubit.fetchQuote()).thenAnswer((_) async {});
  }

  group('Quotes Card.', () {
    testWidgets('On FetchQuoteLoading, it should show skeleton loader.',
        (WidgetTester tester) async {
      listenStub();

      whenListen(
        mockQuoteCubit,
        Stream<QuoteState>.fromIterable(
          <QuoteState>[
            FetchQuoteLoading(mockQuoteCubit.state.data),
          ],
        ),
      );

      await pumpWidget(tester);
      await tester.pump();

      expect(find.byType(Shimmer), findsOneWidget);
    });
    testWidgets('On FetchQuoteSuccess, it should show skeleton loader.',
        (WidgetTester tester) async {
      listenStub();
      const String author = 'John Doe';
      const String en =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam mollis luctus accumsan. Cras porta mattis ultrices. Nunc metus leo, fermentum id euismod vel, fringilla non urna. Morbi id augue diam. Nam laoreet purus non urna luctus tempus. Morbi sit amet orci luctus, dapibus libero sed, semper sem. Praesent nec vulputate arcu. Fusce porta sapien non congue fermentum. Quisque odio odio, blandit ac molestie eu, cursus in diam. Praesent euismod urna risus. Donec ut sem lectus.';
      const String id = 'xxxxxxx';
      whenListen(
        mockQuoteCubit,
        Stream<QuoteState>.fromIterable(
          <QuoteState>[
            FetchQuoteSuccess(
              mockQuoteCubit.state.data,
              QuoteResponseDTO(
                author: author,
                content: en,
                id: id,
              ),
            ),
          ],
        ),
      );

      await pumpWidget(tester);
      await tester.pump();

      expect(find.text('"$en"'), findsOneWidget);
    });
    testWidgets('On FetchQuoteFailed, it should snackbar with a message error.',
        (WidgetTester tester) async {
      listenStub();
      const String errorCode = '524';
      const String message = 'Something went wrong.';
      whenListen(
        mockQuoteCubit,
        Stream<QuoteState>.fromIterable(
          <QuoteState>[
            FetchQuoteFailed(
              mockQuoteCubit.state.data,
              errorCode: errorCode,
              message: message,
            ),
          ],
        ),
      );

      await pumpWidget(tester);
      await tester.pump();

      /// Find snackbar with a child of error message.
      expect(
        find.descendant(
          matching: find.text(message),
          of: find.byType(SnackBar),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Periodic call should should be executed accordingly.',
        (WidgetTester tester) async {
      listenStub();

      await pumpWidget(tester);
      await tester.pump();

      const int numberOfTimes = 4;

      for (int i = 0; i < numberOfTimes; i++) {
        await tester.pump(const Duration(seconds: 15));
      }

      /// Verify that after a 15 sec it calles fetchQuotes. Total call should be 5 since the first call is triggered in init state the next 4 is set from numberOfTimes.
      verify(() => mockQuoteCubit.fetchQuote()).called(numberOfTimes + 1);
    });
  });
}
