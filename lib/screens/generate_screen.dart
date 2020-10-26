import "package:flutter/material.dart";
import 'package:qr_flutter/qr_flutter.dart';

import '../widgets/header.dart';

class QRGenerate extends StatefulWidget {
  @override
  _QRGenerateState createState() => _QRGenerateState();
}

class _QRGenerateState extends State<QRGenerate> {
  final _headerTitle = "Generate a QR code";
  var _idTextField = '';
  var _qrOpacity = 0.0;

  void _generateQR() {
    setState(() {
      _qrOpacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: Header(_headerTitle),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: _mediaQuery.size.height * 0.05,
            left: _mediaQuery.size.width * 0.12,
            right: _mediaQuery.size.width * 0.12,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID (optional)',
                  ),
                  onSubmitted: (String value) => _idTextField = value,
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
                      style: _theme.textTheme.bodyText1.copyWith(fontSize: 20)),
                  onPressed: () => {_generateQR()},
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.08),
                child: AnimatedOpacity(
                  opacity: _qrOpacity,
                  duration: Duration(seconds: 1),
                  child: QrImage(
                    data: _idTextField,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
