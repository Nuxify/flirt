// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flirt/domain/models/api_response.dart';
import 'package:flirt/domain/models/quote/quote_response.dart';
import 'package:flirt/infrastructures/repository/quote_repository.dart';
import 'package:flirt/module/home/application/service/cubit/home_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockQuoteRepository extends Mock implements QuoteRepository {}

void main() {
  late MockQuoteRepository mockQuoteRepository;

  setUp(() {
    mockQuoteRepository = MockQuoteRepository();
  });
  group('Quote cubit.', () {
    blocTest<HomeCubit, HomeState>(
      'On successful fetch quote, it should emit FetchQuoteSuccess.',
      build: () {
        when(() => mockQuoteRepository.fetchQuote()).thenAnswer((_) async {
          return QuoteResponse(author: '', content: '');
        });

        return HomeCubit(quoteRepository: mockQuoteRepository);
      },
      act: (HomeCubit cubit) => cubit.fetchQuote(),
      expect: () => <TypeMatcher<HomeState>>[
        isA<FetchQuoteLoading>(),
        isA<FetchQuoteSuccess>(),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'On failed fetch quote, it should emit FetchQuoteFailed.',
      build: () {
        when(() => mockQuoteRepository.fetchQuote()).thenThrow(
          APIResponse<QuoteResponse>(
            message: '',
            success: false,
            errorCode: '',
            data: QuoteResponse(author: '', content: ''),
          ),
        );

        return HomeCubit(quoteRepository: mockQuoteRepository);
      },
      act: (HomeCubit cubit) => cubit.fetchQuote(),
      expect: () => <TypeMatcher<HomeState>>[
        isA<FetchQuoteLoading>(),
        isA<FetchQuoteFailed>(),
      ],
    );
  });
}
