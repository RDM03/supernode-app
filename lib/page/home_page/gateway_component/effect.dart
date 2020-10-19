import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/demo/gateways_dao.dart';
import 'package:supernodeapp/common/daos/gateways_dao.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/home_page/action.dart';
import 'package:supernodeapp/page/home_page/gateway_component/item_state.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'action.dart';
import 'state.dart';

Effect<GatewayState> buildEffect() {
  return combineEffects(<Object, Effect<GatewayState>>{
    Lifecycle.initState: _initState,
    GatewayAction.onAdd: _onAddAction,
    GatewayAction.onProfile: _onProfile,
    GatewayAction.onDelete: _onDelete,
    GatewayAction.onLoadPage: _onLoadPage,
  });
}

GatewaysDao _buildGatewaysDao(Context<GatewayState> ctx) {
  return ctx.state.isDemo ? DemoGatewaysDao() : GatewaysDao();
}

void _initState(Action action, Context<GatewayState> ctx) {
  const period = const Duration(seconds: 60 * 5);

  Timer.periodic(period, (timer) {
    //到时回调
    ctx.dispatch(HomeActionCreator.onGateways());
  });
}

void _onAddAction(Action action, Context<GatewayState> ctx) {
  Navigator.of(ctx.context).pushNamed('add_gateway_page', arguments: {
    'fromPage': 'home',
    'location': ctx.state.location
  }).then((_) {
    ctx.dispatch(HomeActionCreator.onGateways());
  });
}

void _onProfile(Action action, Context<GatewayState> ctx) {
  GatewayItemState data = action.payload;
  ctx.dispatch(GatewayActionCreator.profile(data));

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

void _onDelete(Action action, Context<GatewayState> ctx) async {
  GatewayItemState data = action.payload;
  String id = data.id;
  GatewaysDao dao = GatewaysDao();

  dao.deleteGateway(id).then((res) {
    Scaffold
        .of(ctx.context)
        .showSnackBar(
        SnackBar(
            content: Text( res.isEmpty?"${data.name} deleted":"Deleting gateway failed: ${res["message"]}")));
    //TODO reload
  }).catchError((err) {
    Scaffold
        .of(ctx.context)
        .showSnackBar(
        SnackBar(
            content: Text('Deleting gateway failed: $err')));
  });
}

void _onLoadPage(Action action, Context<GatewayState> ctx) async {
  final page = action.payload['page'] as int;
  final completer = action.payload['completer'] as Completer;
  if (page == 0) {
    completer.complete(ctx.state.list);
    return;
  }

  try {
    GatewaysDao dao = _buildGatewaysDao(ctx);
    SettingsState settingsData = GlobalStore.store.getState().settings;
    var orgId = settingsData.selectedOrganizationId;
    Map data = {"organizationID": orgId, "offset": page, "limit": 10};

    var res = await dao.list(data);
    mLog('GatewaysDao list', res);

    // [0-9]\d{0,1}\.[0-9]\d{0,1}\.[0-9]\d{0,1}
    // 用于匹配版本号 允许范围 0.0.0 -> 99.99.99
    var reg = RegExp(r"[0-9]\d{0,1}\.[0-9]\d{0,1}\.[0-9]\d{0,1}");

    // int allValues = 0;
    List<GatewayItemState> list = [];

    List tempList = res['result'] as List;

    if (tempList.length > 0) {
      for (int index = 0; index < tempList.length; index++) {
        RegExp modelReg = new RegExp(r'(?<=(Gateway Model: )).+(?=[\n])');
        RegExpMatch modelRegRes =
            modelReg.firstMatch(tempList[index]['description']);
        if (modelRegRes != null) {
          tempList[index]['model'] = modelRegRes.group(0);
        }

        RegExp versionReg = new RegExp(r'(?<=(Gateway OsVersion: )).+');
        RegExpMatch versionRegRes =
            versionReg.firstMatch(tempList[index]['description']);
        if (versionRegRes != null) {
          tempList[index]['osversion'] = versionRegRes.group(0);
        }

        // allValues += tempList[index]['location']['accuracy'];
        Iterable<Match> matches =
            reg.allMatches(tempList[index]['description']);
        String description = '';
        for (Match m in matches) {
          description = m.group(0);
        }

        tempList[index]['description'] = description;

        list.add(GatewayItemState.fromMap(tempList[index]));
      }
    }
    ctx.dispatch(GatewayActionCreator.addGateways(list));
    completer.complete(list);
  } catch (e) {
    completer.completeError(e);
  }
}