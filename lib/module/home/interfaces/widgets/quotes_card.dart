import 'dart:async';

import 'package:flirt/configs/themes.dart';
import 'package:flirt/module/quote/service/cubit/quote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:shimmer/shimmer.dart';

class QuotesCard extends StatefulWidget {
  const QuotesCard({Key? key}) : super(key: key);

  @override
  State<QuotesCard> createState() => _QuotesCardState();
}

class _QuotesCardState extends State<QuotesCard> {
  Timer? _quoteTimer;

  @override
  void initState() {
    super.initState();
    context.read<QuoteCubit>().fetchQuote();
    _quoteTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => context.read<QuoteCubit>().fetchQuote(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _quoteTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final double _width = MediaQuery.of(context).size.width;

    return BlocBuilder<QuoteCubit, QuoteState>(
      buildWhen: (QuoteState previous, QuoteState current) =>
          current is FetchQuoteSuccess || current is FetchQuoteLoading,
      builder: (BuildContext context, QuoteState state) {
        if (state is FetchQuoteSuccess) {
          return FadeIn(
            duration: const Duration(milliseconds: 800),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.1),
              child: Text(
                '"${state.quoteResponse.en}"', // Display the quotes with en key.
                textAlign: TextAlign.center,
                style: _theme.textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Nunito',
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else {
          return FadeIn(
            duration: const Duration(milliseconds: 800),
            child: Shimmer.fromColors(
              baseColor: shimmerBase,
              highlightColor: shimmerGlow,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                ),
                child: const Text(
                  'This template is made with <3 by Nuxify',
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
