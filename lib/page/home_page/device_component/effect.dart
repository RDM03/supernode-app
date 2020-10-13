import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:majascan/majascan.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'action.dart';
import 'state.dart';

Effect<DeviceState> buildEffect() {
  return combineEffects(<Object, Effect<DeviceState>>{
    DeviceAction.onQrScan: _onQrScan,
    DeviceAction.onOpen: _onOpen,
  });
}

void _onOpen(Action action, Context<DeviceState> ctx) {
  Navigator.pushNamed(ctx.context, 'device_mapbox_page', arguments: {
    'isDemo': ctx.state.isDemo
  });
}

void _onQrScan(Action action, Context<DeviceState> ctx) async{
  String errResult = "none";
  String qrResult;
  try {
    qrResult = await MajaScan.startScan(
        title: FlutterI18n.translate(ctx.context, 'scan_code'),
        barColor: buttonPrimaryColor,
        titleColor: backgroundColor,
        qRCornerColor: buttonPrimaryColor,
        qRScannerColor: buttonPrimaryColorAccent);
  } on PlatformException catch (ex) {
    if (ex.code == MajaScan.CameraAccessDenied) {
        errResult = "Camera permission was denied";
    } else {
        errResult = "Unknown Error $ex";
    }
  } on FormatException {
      errResult = "You pressed the back button before scanning anything";
  } catch (ex) {
      errResult = "Unknown Error $ex";
  };
  mLog("count", "error ${errResult}");
  mLog("count", "result ${qrResult}");
  ctx.dispatch(DeviceActionCreator.qrScan(qrResult));

  try {
//  List itemData = qrResult.split(',');
//    List snData = itemData[0].split(':');
//    String number = snData[1];

//    if (Reg.onValidSerialNumber(number)) {
//      _register(ctx, number);
//      return;
//    }
  } catch (err) {
//    tip(ctx.context, 'startScan: $err');
  }
  //Navigator.pushNamed(ctx.context, 'choose_application_page');
}
