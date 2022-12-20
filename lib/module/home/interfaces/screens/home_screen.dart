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
  ButtonStyle buttonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    side: MaterialStateProperty.all(
      const BorderSide(color: Colors.white),
    ),
  );

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
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // ignore: use_decorated_box
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: flirtGradient),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: flirtGradient,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const QuotesCard(),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.05),
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
                          'Made with ♥️ by Nuxify',
                          style: theme.textTheme.caption?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        onTap: () => launchUrlString('https://nuxify.tech/'),
                      ),
                      Text(
                        'Build #7',
                        style: theme.textTheme.caption
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width * 0.45,
                  padding: EdgeInsets.only(top: height * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ListQuotes(),
                            ),
                          );
                        },
                        style: buttonStyle,
                        child: const Text(
                          'Quotes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ListAuthors(),
                            ),
                          );
                        },
                        style: buttonStyle,
                        child: const Text(
                          'Authors',
                          style: TextStyle(color: Colors.white),
                        ),
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
