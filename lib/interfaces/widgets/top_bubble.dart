import 'package:flutter/material.dart';

class TopBubble extends StatelessWidget {
  const TopBubble({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);
    return Positioned(
      top: 0,
      child: SizedBox(
        height: mediaQuery.size.height * 0.20,
        width: mediaQuery.size.width * 0.50,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(60),
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
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
