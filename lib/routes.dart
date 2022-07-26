import 'package:flirt/module/home/interfaces/screens/home_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes =
    <String, Widget Function(BuildContext)>{
  HomeScreen.routeName: (BuildContext ctx) => const HomeScreen(),
};
