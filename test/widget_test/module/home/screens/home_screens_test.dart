import 'package:bloc_test/bloc_test.dart';
import 'package:flirt/module/home/interfaces/screens/home_screen.dart';
import 'package:flirt/module/home/service/cubit/quote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockQuoteCubit extends MockCubit<QuoteState> implements QuoteCubit {}

void main() {
  late MockQuoteCubit mockQuoteCubit;
  const String title = 'Flirt';

  setUp(() {
    mockQuoteCubit = MockQuoteCubit();
  });

  Future<void> _pumpWidget(WidgetTester tester) async => tester.pumpWidget(
        BlocProvider<QuoteCubit>(
          create: (BuildContext context) => mockQuoteCubit,
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );
  void _listenStub() {
    when(() => mockQuoteCubit.state).thenReturn(QuoteInitial());
    when(() => mockQuoteCubit.fetchQuote()).thenAnswer((_) async {});
  }

  group('Home Screen.', () {
    /// Old test case
    group('Old test case.', () {
      testWidgets('There should be QuotesCard custom widget.',
          (WidgetTester tester) async {
        _listenStub();
        await _pumpWidget(tester);

        await tester.pump();
      });
      testWidgets(
        'Flirt title should be visible also Made with <3 by Nuxify.',
        (WidgetTester tester) async {
          _listenStub();
          await _pumpWidget(tester);
          await tester.pump();

          expect(find.text(title), findsOneWidget);
          expect(find.textContaining('Made with <3 by Nuxify'), findsOneWidget);
        },
      );
    });

  });
}
