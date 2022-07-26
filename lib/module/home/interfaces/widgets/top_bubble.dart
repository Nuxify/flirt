import 'package:flutter/material.dart';

class TopBubble extends StatelessWidget {
  const TopBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = Theme.of(context);
    return Positioned(
      top: 0,
      child: SizedBox(
        height: 120.0,
        width: _mediaQuery.size.width * 0.65,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(60),
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
          child: Container(
            margin: const EdgeInsets.only(
              left: 50.0,
              top: 10.0,
            ),
            child: const Text(
              'Flirt',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 70,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
