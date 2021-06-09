import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_appcenter/flutter_appcenter.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/configs/sys.dart';

Future<bool> updateDialog(BuildContext ctx) {
  return FlutterAppCenter.checkForUpdate(ctx,
      channelGooglePlay: Sys.channelGooglePlay,
      downloadUrlAndroid: Sys.downloadUrlAndroid,
      dialog: {
        'title': FlutterI18n.translate(ctx, 'update_dialog_title'),
        'subTitle': FlutterI18n.translate(ctx, 'update_dialog_subTitle'),
        'content': FlutterI18n.translate(ctx, 'update_dialog_content'),
        'confirmButtonText': Platform.isAndroid
            ? FlutterI18n.translate(ctx, 'update_dialog_confirm')
            : 'App Store',
        'middleButtonText': Platform.isAndroid ? '' : 'TestFlight',
        'cancelButtonText': FlutterI18n.translate(ctx, 'update_dialog_cancel'),
        'downloadingText':
            FlutterI18n.translate(ctx, 'update_dialog_downloading')
      });
}
