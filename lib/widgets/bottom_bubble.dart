import 'package:flutter/material.dart';

class BottomBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Positioned(
      bottom: 0,
      child: SizedBox(
        height: mediaQuery.size.height * 0.55,
        width: mediaQuery.size.width,
        child: Container(
          child: Image.asset(
            "assets/images/splash.png",
            fit: BoxFit.fitHeight,
            height: mediaQuery.size.height,
            width: mediaQuery.size.width,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(180),
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                theme.primaryColor,
                theme.accentColor,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
