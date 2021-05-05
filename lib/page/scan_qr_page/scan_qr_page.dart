import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';

class ScanQrPage extends StatefulWidget {
  @override
  _ScanQrPageState createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  bool flashEnabled = false;

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
      appBar: AppBars.backArrowAndActionAppBar(
        title: FlutterI18n.translate(context, 'scan_code'),
        action: IconButton(
          icon: Icon(flashEnabled ? Icons.flash_on : Icons.flash_off),
          color: Colors.black,
          onPressed: () async {
            await controller.toggleFlash();
            setState(() => flashEnabled = !flashEnabled);
          },
        ),
        onPress: () async {
          Navigator.of(context).pop();
        },
      ),
      body: QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.grey,
        ),
      ),
    );
  }
}
