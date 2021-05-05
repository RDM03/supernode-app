import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrPage extends StatefulWidget {
  @override
  _ScanQrPageState createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(_listener);
  }

  void _listener(Barcode code) {
    if (result != null) return;
    result = code;
    Navigator.of(context).pop(result.code);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'scan_code')),
      ),
      body: QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }
}
