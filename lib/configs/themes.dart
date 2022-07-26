import 'package:flutter/material.dart';

final ThemeData defaultTheme = _buildDefaultTheme();
const Color kPink = Color(0xFFFB6BA3);

ThemeData _buildDefaultTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _buildDefaultTextTheme(base.textTheme),
    primaryColor: kPink,
    colorScheme: base.colorScheme.copyWith(
      secondary: const Color(0xFF004e92),
    ),
  );
}

TextTheme _buildDefaultTextTheme(TextTheme base) {
  return base.copyWith(
    headline6: base.headline6?.copyWith(fontFamily: 'Nunito'),
    headline5: base.headline5?.copyWith(fontFamily: 'Nunito'),
    headline4: base.headline4?.copyWith(fontFamily: 'Nunito'),
    headline3: base.headline3?.copyWith(fontFamily: 'Nunito'),
    headline2: base.headline2?.copyWith(fontFamily: 'Nunito'),
    headline1: base.headline1?.copyWith(fontFamily: 'Nunito'),
    subtitle2: base.subtitle2?.copyWith(fontFamily: 'Nunito'),
    subtitle1: base.subtitle1?.copyWith(fontFamily: 'Nunito'),
    bodyText2: base.bodyText2?.copyWith(fontFamily: 'Nunito'),
    bodyText1: base.bodyText1?.copyWith(fontFamily: 'Nunito'),
    caption: base.caption?.copyWith(fontFamily: 'Nunito'),
    button: base.button?.copyWith(fontFamily: 'Nunito'),
    overline: base.overline?.copyWith(fontFamily: 'Nunito'),
  );
}

const Color shimmerBase = Colors.white38;
const Color shimmerGlow = Colors.white60;

const List<Color> flirtGradient = <Color>[
  Color(0xFFFB6BA3),
  Color(0xFFFF38A6),
  Color(0xFFEE1E6F),
];
