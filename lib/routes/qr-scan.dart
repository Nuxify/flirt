import "package:flutter/material.dart";

import '../widgets/header.dart';

class QRScan extends StatelessWidget {
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
          ],
        ),
      ),
    );
  }
}
