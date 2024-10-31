import 'package:bloc_test/bloc_test.dart';
import 'package:flirt/core/application/service/cubit/quote_api_cubit.dart';
import 'package:flirt/core/application/service/cubit/quote_dto.dart';
import 'package:flirt/core/module/home/interfaces/widgets/quotes_card.dart';
import 'package:flirt/test/main_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeCubit extends MockCubit<QuoteAPIState> implements QuoteAPICubit {}

void main() {
  late MockHomeCubit mockHomeCubit;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
  });

  Future<void> widgetPumper(WidgetTester tester) => tester.pumpWidget(
        BlocProvider<QuoteAPICubit>(
          create: (BuildContext context) => mockHomeCubit,
          child: universalPumper(
            const Scaffold(
              body: QuotesCard(),
            ),
          ),
        ),
      );

  void initializeListener() {
    when(() => mockHomeCubit.state).thenReturn(
      QuoteAPIState(),
    );
    when(() => mockHomeCubit.fetchQuote()).thenAnswer((_) async {});
  }

  group('Quotes Card.', () {
    testWidgets(
      'On 15 sec, it should trigger another fetchQuote.',
      (WidgetTester tester) async {
        initializeListener();
        await widgetPumper(tester);
        await tester.pump();

        verify(() => mockHomeCubit.fetchQuote()).called(1);

        /// First call
        await tester.pump(const Duration(seconds: 15));

        /// Second call
        await tester.pump(const Duration(seconds: 15));

        verify(() => mockHomeCubit.fetchQuote()).called(2);
      },
    );
    testWidgets(
      'On event is FetchQuoteFailed, it should render properly.',
      (WidgetTester tester) async {
        const String errorMessage = 'Something went wrong';

        whenListen(
          mockHomeCubit,
          Stream<FetchQuoteFailed>.fromIterable(<FetchQuoteFailed>[
            FetchQuoteFailed(
              errorCode: '',
              message: errorMessage,
            ),
          ]),
        );
        initializeListener();
        await widgetPumper(tester);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text(errorMessage), findsOneWidget);
      },
    );
    testWidgets(
      'On event is FetchQuoteSuccess, it should render properly.',
      (WidgetTester tester) async {
        const String content = 'Hello world';
        const String author = 'John Doe';

        whenListen(
          mockHomeCubit,
          Stream<FetchQuoteSuccess>.fromIterable(<FetchQuoteSuccess>[
            FetchQuoteSuccess(
              QuoteResponseDTO(
                author: author,
                content: content,
              ),
            ),
          ]),
        );
        initializeListener();
        await widgetPumper(tester);
        await tester.pump();

        expect(find.text('- $author'), findsOneWidget);
        expect(find.text(content), findsOneWidget);
      },
    );
    testWidgets(
      'On event is FetchQuoteLoading, it should render properly.',
      (WidgetTester tester) async {
        whenListen(
          mockHomeCubit,
          Stream<FetchQuoteLoading>.fromIterable(<FetchQuoteLoading>[
            FetchQuoteLoading(),
          ]),
        );
        initializeListener();
        await widgetPumper(tester);
        await tester.pump();

        expect(find.byType(LinearProgressIndicator), findsOneWidget);
      },
    );
  });
}
