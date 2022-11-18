import 'dart:async';
import 'package:flirt/configs/themes.dart';
import 'package:flirt/module/home/interfaces/screens/list_authors.dart';
import 'package:flirt/module/home/interfaces/screens/list_quotes.dart';
import 'package:flirt/module/home/interfaces/widgets/quotes_card.dart';
import 'package:flutter/material.dart';
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
    final ThemeData theme = Theme.of(context);
    // final double _width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: DecoratedBox(
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
                  padding: EdgeInsets.only(top: height * 0.1),
                  child: Column(
                    children: <Widget>[
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 500),
                        style: TextStyle(
                          color: _fontColor,
                          fontSize: theme.textTheme.displayMedium?.fontSize,
                          fontFamily: theme.textTheme.displayMedium?.fontFamily,
                        ),
                        child: const Text(
                          'Flirt',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        'A Flutter template.',
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      GestureDetector(
                        child: Text(
                          'Made with <3 by Nuxify',
                          style: theme.textTheme.caption?.copyWith(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () => launchUrlString('https://nuxify.tech/'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => ListQuotes(),
                        ),
                      );
                    },
                    child: const Text('List of Quotes'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => ListAuthors(),
                        ),
                      );
                    },
                    child: const Text('List of Authors'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
