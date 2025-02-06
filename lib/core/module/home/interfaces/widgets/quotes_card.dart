import 'dart:async';

import 'package:flirt/core/module/home/application/service/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuotesCard extends StatefulWidget {
  const QuotesCard({super.key});

  @override
  State<QuotesCard> createState() => _QuotesCardState();
}

class _QuotesCardState extends State<QuotesCard> {
  double textOpacity = 1.0;
  Timer? _quoteTimer;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchQuote();
    _quoteTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => context.read<HomeCubit>().fetchQuote(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _quoteTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (HomeState previous, HomeState current) =>
          current is FetchQuoteFailed ||
          current is FetchQuoteSuccess ||
          current is FetchQuoteLoading,
      listener: (BuildContext context, HomeState state) {
        if (state is FetchQuoteFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is FetchQuoteSuccess) {
          setState(() => textOpacity = 1.0);

          context.read<HomeCubit>().storeState(state.quoteResponse);
        } else if (state is FetchQuoteLoading) {
          setState(() => textOpacity = 0);
        }
      },
      buildWhen: (HomeState previous, HomeState current) =>
          current is FetchQuoteSuccess,
      builder: (BuildContext context, HomeState state) {
        if (state is FetchQuoteSuccess) {
          return Padding(
            padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: textOpacity,
              child: Column(
                children: <Widget>[
                  Text(
                    state.quoteResponse.content,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '- ${state.quoteResponse.author}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.only(top: 15),
            width: width * .5,
            child: LinearProgressIndicator(
              color: Colors.white12,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        }
      },
    );
  }
}
