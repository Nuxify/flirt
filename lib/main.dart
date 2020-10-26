import 'package:flutter/material.dart';

import 'widgets/main_button_bar.dart';
import 'widgets/top_bubble.dart';
import 'widgets/bottom_bubble.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flirt',
      home: _HomePageState(),
      theme: ThemeData(
        fontFamily: "Nunito",
        textTheme: ThemeData.light().textTheme.copyWith(
              headline4: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Colors.black,
              ),
              bodyText1: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                color: Colors.white,
              ),
            ),
        primaryColor: Color(0xFF347be0),
        accentColor: Color(0xFF004e92),
      ),
    );
  }
}

class _HomePageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TopBubble(),
          MainButtonBar(),
          BottomBubble(),
        ],
      ),
    );
  }
}
