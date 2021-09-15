import 'package:flutter/material.dart';

class BottomBubble extends StatelessWidget {
  const BottomBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = Theme.of(context);
    return Positioned(
      bottom: 0,
      child: SizedBox(
        height: mediaQuery.size.height * 0.55,
        width: mediaQuery.size.width,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(180),
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
                _theme.primaryColor,
                _theme.colorScheme.secondary,
              ],
            ),
          ),
          child: Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.fitHeight,
            height: mediaQuery.size.height,
            width: mediaQuery.size.width,
          ),
        ),
      ),
    );
  }
}
