import 'package:flutter/material.dart';

import 'config/themes.dart';

import 'screens/generate_screen.dart';
import 'screens/result_screen.dart';
import 'screens/scan_screen.dart';

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
      theme: defaultTheme,
      routes: {
        QRGenerateScreen.routeName: (ctx) => QRGenerateScreen(),
        QRScanScreen.routeName: (ctx) => QRScanScreen(),
        QRResultScreen.routeName: (ctx) => QRResultScreen('', () {}),
      },
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
