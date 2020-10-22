import "package:flutter/material.dart";

import '../widgets/header.dart';

class Generate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: Header(),
      body: Container(
        margin: EdgeInsets.only(
          top: mediaQuery.size.height * 0.05,
          left: mediaQuery.size.width * 0.12,
          right: mediaQuery.size.width * 0.12,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                autofocus: true,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ID (optional)',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Data',
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: FlatButton.icon(
                icon: Icon(Icons.select_all, color: Colors.white),
                label: Text('GENERATE',
                    style: theme.textTheme.bodyText1.copyWith(fontSize: 20)),
                onPressed: () => {},
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
