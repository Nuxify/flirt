import 'package:flutter/material.dart';

final ThemeData defaultTheme = _buildDefaultTheme();

ThemeData _buildDefaultTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _buildDefaultTextTheme(base.textTheme),
    primaryColor: Color(0xFF347be0),
    accentColor: Color(0xFF004e92),
  );
}

TextTheme _buildDefaultTextTheme(TextTheme base) {
  return base.copyWith(
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
  );
}
