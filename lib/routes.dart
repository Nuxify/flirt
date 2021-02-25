import 'package:flutter/material.dart';

import 'package:Flirt/interfaces/screens/generate_screen.dart';
import 'package:Flirt/interfaces/screens/result_screen.dart';
import 'package:Flirt/interfaces/screens/scan_screen.dart';

Map<String, Widget Function(BuildContext)> routes =
    <String, Widget Function(BuildContext)>{
  GenerateScreen.routeName: (BuildContext ctx) => const GenerateScreen(),
  ResultScreen.routeName: (BuildContext ctx) => const ResultScreen(),
  ScanScreen.routeName: (BuildContext ctx) => const ScanScreen(),
};
