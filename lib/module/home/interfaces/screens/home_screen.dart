import 'dart:async';
import 'package:flirt/configs/themes.dart';
import 'package:flirt/module/home/interfaces/widgets/quotes_card.dart';
import 'package:flirt/module/quote/service/cubit/quote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _fontColor = Colors.white;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    context.read<QuoteCubit>().fetchQuote();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_fontColor == Colors.white) {
        setState(() => _fontColor = Colors.white30);
      } else {
        setState(() => _fontColor = Colors.white);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    // final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: flirtGradient,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const QuotesCard(),
                Padding(
                  padding: EdgeInsets.only(top: _height * 0.1),
                  child: Column(
                    children: <Widget>[
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 500),
                        style: TextStyle(
                          color: _fontColor,
                          fontSize: _theme.textTheme.displayMedium?.fontSize,
                          fontFamily:
                              _theme.textTheme.displayMedium?.fontFamily,
                        ),
                        child: const Text(
                          'Flirt',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        'A Flutter template.',
                        style: _theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      GestureDetector(
                        child: Text(
                          'Made with <3 by Nuxify',
                          style: _theme.textTheme.caption?.copyWith(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () => launchUrlString('https://nuxify.tech/'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
