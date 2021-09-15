import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {required this.buttonLabel,
      required this.buttonIcon,
      required this.onPressedFunc,
      Key? key})
      : super(key: key);

  final String buttonLabel;
  final IconData buttonIcon;
  final Function onPressedFunc;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[
              _theme.primaryColor,
              _theme.colorScheme.secondary,
            ],
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: TextButton.icon(
          onPressed: () {
            onPressedFunc();
          },
          label: Text(buttonLabel,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              )),
          icon: Icon(
            buttonIcon,
            color: Colors.white,
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                vertical: 15,
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
