import 'package:flutter/material.dart';

import 'package:Flirt/interfaces/screens/generate_screen.dart';
import 'package:Flirt/interfaces/screens/result_screen.dart';
import 'package:Flirt/interfaces/screens/scan_screen.dart';

Map<String, Widget Function(BuildContext)> routes =
    <String, Widget Function(BuildContext)>{
  QRGenerateScreen.routeName: (BuildContext ctx) => QRGenerateScreen(),
  ResultScreen.routeName: (BuildContext ctx) => ResultScreen('', () {}),
  ScanScreen.routeName: (BuildContext ctx) => ScanScreen(),
};
