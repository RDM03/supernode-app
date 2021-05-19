import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:majascan/majascan.dart';
import 'package:supernodeapp/theme/colors.dart';

Future<String> scanQR(BuildContext context) async {

  return await MajaScan.startScan(
              title: FlutterI18n.translate(context, 'scan_code'),
              barColor: buttonPrimaryColor,
              titleColor: backgroundColor,
              qRCornerColor: buttonPrimaryColor,
              qRScannerColor: buttonPrimaryColorAccent);
              
}