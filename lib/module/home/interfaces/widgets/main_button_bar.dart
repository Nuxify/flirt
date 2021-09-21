import 'package:flirt/interfaces/widgets/rounded_button.dart';
import 'package:flirt/module/record/interfaces/screens/generate/generate_screen.dart';
import 'package:flirt/module/record/interfaces/screens/scan/scan_screen.dart';
import 'package:flutter/material.dart';

class MainButtonBar extends StatelessWidget {
  const MainButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.only(
        top: 140.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        children: <Widget>[
          RoundedButton(
            buttonLabel: 'GENERATE',
            buttonIcon: Icons.select_all,
            onPressedFunc: () {
              Navigator.of(context).pushNamed(
                GenerateScreen.routeName,
              );
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          RoundedButton(
            buttonLabel: 'SCAN',
            buttonIcon: Icons.center_focus_weak,
            onPressedFunc: () {
              Navigator.of(context).pushNamed(
                ScanScreen.routeName,
              );
            },
          )
        ],
      ),
    );
  }
}
