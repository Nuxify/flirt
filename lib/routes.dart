import 'package:flirt/module/home/interfaces/screens/home_screen.dart';
import 'package:flirt/module/record/interfaces/screens/generate/generate_screen.dart';
import 'package:flirt/module/record/interfaces/screens/result/result_screen.dart';
import 'package:flirt/module/record/interfaces/screens/scan/scan_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes =
    <String, Widget Function(BuildContext)>{
  HomeScreen.routeName: (BuildContext ctx) => const HomeScreen(),

  // ================ record module ================
  GenerateScreen.routeName: (BuildContext ctx) => const GenerateScreen(),
  ResultScreen.routeName: (BuildContext ctx) => const ResultScreen(),
  ScanScreen.routeName: (BuildContext ctx) => const ScanScreen(),
};
