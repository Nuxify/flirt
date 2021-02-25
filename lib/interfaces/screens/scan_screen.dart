import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:Flirt/interfaces/screens/result_screen.dart';
import 'package:Flirt/interfaces/widgets/header.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({
    Key key,
  }) : super(key: key);

  static const String routeName = '/scan';

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

const String flashOn = 'FLASH ON';
const String flashOff = 'FLASH OFF';
const String frontCamera = 'FRONT CAMERA';
const String backCamera = 'BACK CAMERA';

class _ScanScreenState extends State<ScanScreen> {
  final String _headerTitle = 'Scan a QR code';
  String qrText = '';
  String flashState = flashOn;
  String cameraState = frontCamera;
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
      controller.scannedDataStream.listen((String scanData) {
        setState(() {
          qrText = scanData;
        });
        controller.pauseCamera();
        if (qrText != '') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => ResultScreen(
                qrData: qrText,
                rescan: rescan,
              ),
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
        appBar: Header(title: _headerTitle),
        body: Row(children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
              overlay: QrScannerOverlayShape(
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
