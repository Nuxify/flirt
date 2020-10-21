import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MainButtonBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final lrPadding = 30.0;
    return Positioned(
      top: 0,
      child: Container(
        margin: EdgeInsets.only(
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
                "Flirt",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 70,
                  foreground: Paint()
                    ..shader = ui.Gradient.linear(
                      Offset(0, 20),
                      Offset(150, 20),
                      <Color>[Colors.white, Colors.white],
                    ),
                ),
              ),
              Container(
                width: mediaQuery.size.width,
                padding: EdgeInsets.only(top: 50),
                child: ButtonBar(
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
                        icon: Icon(Icons.add_box),
                        label: Text(
                          'GENERATE',
                          style:
                              theme.textTheme.bodyText1.copyWith(fontSize: 20),
                        ),
                        onPressed: () {},
                        padding: EdgeInsets.only(
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
                        icon: Icon(Icons.center_focus_weak),
                        label: Text('SCAN',
                            style: theme.textTheme.bodyText1
                                .copyWith(fontSize: 20)),
                        onPressed: () {},
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
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
