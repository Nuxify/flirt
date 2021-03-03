import 'package:flutter/material.dart';

import 'package:Flirt/interfaces/widgets/bottom_bubble.dart';
import 'package:Flirt/interfaces/widgets/main_button_bar.dart';
import 'package:Flirt/interfaces/widgets/top_bubble.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                const TopBubble(),
                const MainButtonBar(),
                const BottomBubble(),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
