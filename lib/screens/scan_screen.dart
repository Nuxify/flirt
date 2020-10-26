import "package:flutter/material.dart";
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../screens/result_screen.dart';
import '../widgets/header.dart';

class QRScan extends StatefulWidget {
  @override
  _QRScanState createState() => _QRScanState();
}

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class _QRScanState extends State<QRScan> {
  final _headerTitle = "Scan a QR code";
  var qrText = '';
  var flashState = flashOn;
  var cameraState = frontCamera;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

    void rescan() {
      setState(() {
        qrText = '';
      });
      controller.resumeCamera();
    }

    void onQRViewCreated(QRViewController controller) {
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) {
        setState(() {
          qrText = scanData;
        });
        controller.pauseCamera();
        if (qrText != '') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRResult(qrText, rescan),
            ),
          );
        }
      });
    }

    return WillPopScope(
      onWillPop: () async {
        controller.pauseCamera();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Header(_headerTitle),
        body: Row(children: [
          Expanded(
            flex: 1,
            child: QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 30,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
