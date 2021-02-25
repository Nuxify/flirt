import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:Flirt/interfaces/screens/generate_screen.dart';
import 'package:Flirt/interfaces/screens/scan_screen.dart';

class MainButtonBar extends StatelessWidget {
  const MainButtonBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);
    const double lrPadding = 30.0;

    return Positioned(
      top: 0,
      child: Container(
        margin: const EdgeInsets.only(
          top: 50,
          left: lrPadding,
          right: lrPadding,
        ),
        child: SizedBox(
          width: mediaQuery.size.width - (lrPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Flirt',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 70,
                  foreground: Paint()
                    ..shader = ui.Gradient.linear(
                      const Offset(0, 20),
                      const Offset(150, 20),
                      <Color>[Colors.white, Colors.white],
                    ),
                ),
              ),
              Container(
                width: mediaQuery.size.width,
                padding: const EdgeInsets.only(top: 50),
                child: ButtonBar(
                  overflowButtonSpacing: 10,
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [theme.primaryColor, theme.accentColor],
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: FlatButton.icon(
                        icon: const Icon(Icons.select_all),
                        label: Text(
                          'GENERATE',
                          style:
                              theme.textTheme.bodyText1.copyWith(fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            GenerateScreen.routeName,
                          );
                        },
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [theme.primaryColor, theme.accentColor],
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: FlatButton.icon(
                        icon: const Icon(Icons.center_focus_weak),
                        label: Flexible(
                          child: Text(
                            'SCAN',
                            style: theme.textTheme.bodyText1
                                .copyWith(fontSize: 18),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            ScanScreen.routeName,
                          );
                        },
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        color: Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
