import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/scheduler.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:majascan/majascan.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/gateways_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';

import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Effect<AddGatewayState> buildEffect() {
  return combineEffects(<Object, Effect<AddGatewayState>>{
    Lifecycle.initState: _initState,
    AddGatewayAction.onQrScan: _onQrScan,
    AddGatewayAction.onProfile: _onProfile,
  });
}

void _initState(Action action, Context<AddGatewayState> ctx) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    ctx.state.mapCtl.addSymbol(MapMarker(
      point: ctx.state.markerPoint,
      image: AppImages.gateways,
    ));
  });
  //   ctx.dispatch(GatewayProfileActionCreator.initState());
}

void _onQrScan(Action action, Context<AddGatewayState> ctx) async {
  String qrResult = await MajaScan.startScan(
      title: FlutterI18n.translate(ctx.context, 'scan_code'),
      barColor: buttonPrimaryColor,
      titleColor: backgroundColor,
      qRCornerColor: buttonPrimaryColor,
      qRScannerColor: buttonPrimaryColorAccent);
  ctx.dispatch(AddGatewayActionCreator.serialNumber(qrResult));

  try {
    List itemData = qrResult.split(',');
    List snData = itemData[0].split(':');
    String number = snData[1];

    if (Reg.onValidSerialNumber(number) || qrResult.length == 24) {
      if (Reg.onValidSerialNumber(number)) {
        _register(ctx, number);
      } else {
        _registerReseller(ctx, qrResult);
      }
      return;
    }
  } catch (err) {
    tip(ctx.context, 'startScan: $err');
    if (qrResult?.length == 24) {
      //reseller
      return;
    }
  }

  Navigator.push(
    ctx.context,
    MaterialPageRoute(
        maintainState: false,
        fullscreenDialog: true,
        builder: (context) {
          return ctx.buildComponent('profile');
        }),
  );
}

void _onProfile(Action action, Context<AddGatewayState> ctx) {
  var curState = ctx.state;

  if ((curState.formKey.currentState as FormState).validate()) {
    String sn = curState.serialNumberCtl.text;
    if (Reg.onValidSerialNumber(sn) || sn.length == 24) {
      if (Reg.onValidSerialNumber(sn)) {
        _register(ctx, sn);
      } else {
        _registerReseller(ctx, sn);
      }
      return;
    }

    Navigator.push(
      ctx.context,
      MaterialPageRoute(
          maintainState: false,
          fullscreenDialog: true,
          builder: (context) {
            return ctx.buildComponent('profile');
          }),
    );
  }
}

void _register(Context<AddGatewayState> ctx, String serialNumber) async {
  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
  GatewaysDao dao = GatewaysDao();

  Map data = {"organizationId": orgId, "sn": serialNumber.trim()};
  final loading = await Loading.show(ctx.context);
  dao.register(data).then((res) {
    loading.hide();
    mLog('Gateway register', res);

    if (res.containsKey('status')) {
      tip(ctx.context, res['status'], success: true);
      if (ctx.state.fromPage == 'home') {
        Navigator.of(ctx.context).pop();
      }
    }
  }).catchError((err) {
    loading.hide();
    tip(ctx.context, 'Gateway register: $err');
  });
}

void _registerReseller(Context<AddGatewayState> ctx, String manufacturerNr) async {
  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
  GatewaysDao dao = GatewaysDao();

  Map data = {"manufacturerNr": manufacturerNr.trim(), "organizationId": orgId};
  final loading = await Loading.show(ctx.context);
  dao.registerReseller(data).then((res) {
    loading.hide();
    mLog('Reseller register', res);

    if (res.containsKey('status')) {
      showInfoDialog(
        ctx.context,
        IosStyleBottomDialog2 (
            context: ctx.context,
            child: Text(
              FlutterI18n.translate(ctx.context, 'register_reseller_success').replaceFirst('{0}', manufacturerNr),
              style: kBigFontOfBlack,
              textAlign: TextAlign.center
            )
        )
      );
      ctx.state.serialNumberCtl.text = "";
    }
  }).catchError((err) {
    loading.hide();
    tip(ctx.context, 'Reseller register: $err');
  });
}
