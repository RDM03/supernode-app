import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:majascan/majascan.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

Future<String> scanQR(BuildContext context) async {
  return await MajaScan.startScan(
      title: FlutterI18n.translate(context, 'scan_code'),
      barColor: ColorsTheme.of(context).mxcBlue,
      titleColor: ColorsTheme.of(context).primaryBackground,
      qRCornerColor: ColorsTheme.of(context).mxcBlue,
      qRScannerColor: buttonPrimaryColorAccent);
}
