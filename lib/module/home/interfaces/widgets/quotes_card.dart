import 'dart:async';
import 'package:flirt/module/home/service/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final ThemeData theme = Theme.of(context);
    final double width = MediaQuery.of(context).size.width;
    // final double _height = MediaQuery.of(context).size.height;

    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (HomeState previous, HomeState current) =>
          current is FetchQuoteFailed,
      listener: (BuildContext context, HomeState state) {
        if (state is FetchQuoteFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      buildWhen: (HomeState previous, HomeState current) =>
          current is FetchQuoteSuccess || current is FetchQuoteLoading,
      builder: (BuildContext context, HomeState state) {
        if (state is FetchQuoteSuccess) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Text(
              '"${state.quoteResponse.content}"', // Display the quotes with en key.
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                fontFamily: 'Nunito',
                color: Colors.white,
              ),
            ),
          );
        } else {
          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.white,
            ),
            child: const Text(
              'This template is made with <3 by Nuxify',
            ),
          );
        }
      },
    );
  }
}
