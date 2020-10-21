import 'package:flutter/material.dart';

class TopBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Positioned(
      top: 0,
      child: SizedBox(
        height: mediaQuery.size.height * 0.20,
        width: mediaQuery.size.width * 0.50,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(60),
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
