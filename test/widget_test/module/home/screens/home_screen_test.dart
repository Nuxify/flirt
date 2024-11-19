import 'package:bloc_test/bloc_test.dart';
import 'package:flirt/core/application/service/cubit/quote_api_cubit.dart';
import 'package:flirt/core/application/service/cubit/quote_dto.dart';
import 'package:flirt/core/module/home/interfaces/screens/home_screen.dart';
import 'package:flirt/core/module/home/interfaces/widgets/quotes_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockQuoteCubit extends MockCubit<QuoteApiState>
    implements QuoteApiCubit {}

void main() {
  late MockQuoteCubit mockQuoteCubit;

  setUp(() {
    mockQuoteCubit = MockQuoteCubit();
  });

  Future<void> pumpWidget(WidgetTester tester) async => tester.pumpWidget(
        BlocProvider<QuoteApiCubit>(
          create: (BuildContext context) => mockQuoteCubit,
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

  void listenStub() {
    when(() => mockQuoteCubit.state).thenReturn(
      QuoteApiState(
        data: QuoteStateDTO(authors: <String>[], quotes: <QuoteResponseDTO>[]),
      ),
    );
    when(() => mockQuoteCubit.fetchQuote()).thenAnswer((_) async {});
  }

  group('Home Screen.', () {
    testWidgets('Should render properly.', (WidgetTester tester) async {
      listenStub();
      await pumpWidget(tester);

      await tester.pump();

      expect(find.byType(QuotesCard), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('v1.3.0'), findsOneWidget);
    });
  });
}
