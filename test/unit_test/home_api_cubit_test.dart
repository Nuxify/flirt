// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flirt/core/domain/models/api_error_response.dart';
import 'package:flirt/core/domain/models/api_response.dart';
import 'package:flirt/core/domain/models/quote/quote_response.dart';
import 'package:flirt/core/infrastructures/repository/quote_repository.dart';
import 'package:flirt/core/module/home/application/service/cubit/home_api_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockQuoteRepository extends Mock implements QuoteRepository {}

void main() {
  late MockQuoteRepository mockQuoteRepository;

  setUp(() {
    mockQuoteRepository = MockQuoteRepository();
  });
  group('Quote cubit.', () {
    blocTest<HomeAPICubit, HomeAPIState>(
      'On successful fetch quote, it should emit FetchQuoteSuccess.',
      build: () {
        when(() => mockQuoteRepository.fetchQuote()).thenAnswer((_) async {
          return APIListResponse<QuoteResponse>(
            success: true,
            message: '',
            data: <QuoteResponse>[
              QuoteResponse(author: '', quote: ''),
            ],
          );
        });

        return HomeAPICubit(quoteRepository: mockQuoteRepository);
      },
      act: (HomeAPICubit cubit) => cubit.fetchQuote(),
      expect: () => <TypeMatcher<HomeAPIState>>[
        isA<FetchQuoteLoading>(),
        isA<FetchQuoteSuccess>(),
      ],
    );

    blocTest<HomeAPICubit, HomeAPIState>(
      'On failed fetch quote, it should emit FetchQuoteFailed.',
      build: () {
        when(() => mockQuoteRepository.fetchQuote()).thenThrow(
          APIErrorResponse(
            message: '',
            errorCode: '',
          ),
        );

        return HomeAPICubit(quoteRepository: mockQuoteRepository);
      },
      act: (HomeAPICubit cubit) => cubit.fetchQuote(),
      expect: () => <TypeMatcher<HomeAPIState>>[
        isA<FetchQuoteLoading>(),
        isA<FetchQuoteFailed>(),
      ],
    );
  });
}
