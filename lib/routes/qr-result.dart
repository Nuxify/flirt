import 'package:flutter/material.dart';

import '../widgets/header.dart';

class QRResult extends StatelessWidget {
  final qrData;
  final Function rescan;

  QRResult(this.qrData, this.rescan);

  final _headerTitle = "QR Data";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        rescan();
        return true;
      },
      child: Scaffold(
        appBar: Header(_headerTitle),
        body: Column(
          children: [
            Text(qrData),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                rescan();
              },
              child: Text('Scan again'),
            )
          ],
        ),
      ),
    );
  }
}
