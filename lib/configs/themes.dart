import 'package:flirt/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

final ThemeData defaultTheme = _buildDefaultTheme();
const Color kPink = Color(0xFFFB6BA3);

ThemeData _buildDefaultTheme() {
  final ThemeData base = ThemeData.light();
  return ThemeData(
    fontFamily: FontFamily.nunito,
    primaryColor: kPink,
    colorScheme: base.colorScheme.copyWith(
      secondary: const Color(0xFF004e92),
    ),
  );
}

const Color shimmerBase = Colors.white38;
const Color shimmerGlow = Colors.white60;

const List<Color> flirtGradient = <Color>[
  Color(0xFFFB6BA3),
  Color(0xFFFF38A6),
  Color(0xFFEE1E6F),
];
