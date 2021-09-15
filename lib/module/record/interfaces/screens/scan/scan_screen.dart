import 'package:flirt/interfaces/widgets/header.dart';
import 'package:flirt/module/record/interfaces/screens/result/result_screen.dart';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({
    Key? key,
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
  String qrText = '';
  String flashState = flashOn;
  String cameraState = frontCamera;
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void rescan() {
      setState(() {
        qrText = '';
      });
      controller.resumeCamera();
    }

    void onQRViewCreated(QRViewController controller) {
      this.controller = controller;
      controller.scannedDataStream.listen((Barcode scanData) {
        setState(() {
          qrText = scanData.code;
        });
        controller.pauseCamera();
        if (qrText != '') {
          Navigator.of(context).push(
            MaterialPageRoute<dynamic>(
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
        appBar: const Header(title: 'Scan a QR code'),
        body: Row(children: <Widget>[
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
