import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/select_picker.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/gateways.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/network_server.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/organization.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/log.dart';

import 'action.dart';
import 'state.dart';

Effect<GatewayProfileState> buildEffect() {
  return combineEffects(<Object, Effect<GatewayProfileState>>{
    Lifecycle.initState: _initState,
    GatewayProfileAction.initState: _initState,
    GatewayProfileAction.onNetworkServerList: _onNetworkServerList,
    GatewayProfileAction.onNetworkServerPicker: _onNetworkServerPicker,
    GatewayProfileAction.onGatewayProfilePicker: _onGatewayProfilePicker,
    GatewayProfileAction.update: _update,
  });
}

GatewaysDao _buildGatewaysDao(Context<GatewayProfileState> ctx) {
  return ctx.context.read<SupernodeRepository>().gateways;
}

NetworkServerDao _buildNetworkServerDao(Context<GatewayProfileState> ctx) {
  return ctx.context.read<SupernodeRepository>().networkServer;
}

OrganizationDao _buildOrganizationDao(Context<GatewayProfileState> ctx) {
  return ctx.context.read<SupernodeRepository>().organization;
}

void _initState(Action action, Context<GatewayProfileState> ctx) {
  // if(ctx.state.networkServerList.isNotEmpty) return;
  Future.delayed(Duration(seconds: 1), () {
    _onNetworkServerList(action, ctx);

    // if(ctx.state.networkServerID.isNotEmpty){
    //   _gatewayProfile(ctx,ctx.state.networkServerID);
    // }
  });
}

void _onNetworkServerPicker(Action action, Context<GatewayProfileState> ctx) {
  var curState = ctx.state;
  int selectedSNIndex = -1;

  List data = curState.networkServerList.asMap().keys.map((index) {
    if (curState.networkServerList[index]['id'] == curState.networkServerID) {
      selectedSNIndex = index;
    }

    return curState.networkServerList[index]['name'];
  }).toList();

  selectPicker(ctx.context, data: data, value: selectedSNIndex,
      onSelected: (sIndex) {
    String id = curState.networkServerList[sIndex]['id'];
    String name = curState.networkServerList[sIndex]['name'];
    ctx.dispatch(GatewayProfileActionCreator.networkServerId(id, name));

    if (ctx.state.gatewayProfileList.isEmpty) {
      _gatewayProfile(ctx, id);
    }
  });
}

void _onGatewayProfilePicker(Action action, Context<GatewayProfileState> ctx) {
  var curState = ctx.state;
  int selectedIndex = -1;

  List data = curState.gatewayProfileList.asMap().keys.map((index) {
    if (curState.gatewayProfileList[index]['id'] == curState.gatewayProfileID) {
      selectedIndex = index;
    }

    return curState.gatewayProfileList[index]['name'];
  }).toList();

  selectPicker(ctx.context, data: data, value: selectedIndex,
      onSelected: (sIndex) {
    String id = curState.gatewayProfileList[sIndex]['id'];
    String name = curState.gatewayProfileList[sIndex]['name'];
    ctx.dispatch(GatewayProfileActionCreator.gatewayProfileId(id, name));
  });
}

void _gatewayProfile(Context<GatewayProfileState> ctx, String id) {
  GatewaysDao dao = _buildGatewaysDao(ctx);

  Map data = {"networkServerID": id, "offset": 0, "limit": 999};

  dao.profile(data).then((res) {
    mLog('Gateway profile', res);
    if (res.containsKey('result') && res['result'].length > 0) {
      ctx.dispatch(
          GatewayProfileActionCreator.gatewayProfileList(res['result']));
    } else {
      tip(ctx.context, res);
    }
  }).catchError((err) {
    // tip(ctx.context,'Gateway profile $err');
  });
}

void _update(Action action, Context<GatewayProfileState> ctx) async {
  var curState = ctx.state;

  if (curState.networkServerID.isEmpty) {
    tip(ctx.context, FlutterI18n.translate(ctx.context, 'reg_network_server'));
    return;
  }

  if (curState.gatewayProfileID.isEmpty) {
    tip(ctx.context, FlutterI18n.translate(ctx.context, 'reg_gateway_profile'));
    return;
  }

  LatLng location = curState.markerPoint ?? curState.location;

  if (location == null) {
    tip(ctx.context,
        FlutterI18n.translate(ctx.context, 'reg_gateway_location'));
    return;
  }

  if ((curState.formKey.currentState as FormState).validate()) {
    final loading = Loading.show(ctx.context);

    GatewaysDao dao = _buildGatewaysDao(ctx);

    String orgId = ctx.context.read<SupernodeCubit>().state.orgId;

    Map data = {
      "gateway": {
        "id": curState.idCtl.text.trim(),
        "name": curState.nameCtl.text.trim(),
        "description": curState.descriptionCtl.text.trim(),
        "location": {
          "latitude": location.latitude,
          "longitude": location.longitude,
          "altitude": double.parse(curState.altitudeCtl.text),
          "source": "UNKNOWN",
          "accuracy": 0
        },
        "organizationID": orgId,
        "discoveryEnabled": curState.discoveryEnabled,
        "networkServerID": curState.networkServerID,
        "gatewayProfileID": curState.gatewayProfileID,
        // "boards": [
        //   {
        //     "fpgaID": "string",
        //     "fineTimestampKey": "string"
        //   }
        // ]
      }
    };

    dao.add(data).then((res) {
      loading.hide();
      mLog('GatewaysDao add', res);

      tip(ctx.context, FlutterI18n.translate(ctx.context, 'update_success'),
          success: true);

      Navigator.of(ctx.context).pop();
    }).catchError((err) {
      loading.hide();
      // tip(ctx.context,'Gateways add: $err');
    }).timeout(Duration(seconds: 5), onTimeout: (){
      loading.hide();
    });
  }
}

Future<void> _getOrganizations(
    Action action, Context<GatewayProfileState> ctx) async {
  OrganizationDao dao = _buildOrganizationDao(ctx);

  Map data = {"offset": 0, "limit": 999};

  final res = await dao.list(data);
  mLog('OrganizationDao list', res);

  ctx.context.read<SupernodeCubit>().setOrganizationId(res['result'][0]['id']);
  _onNetworkServerList(action, ctx);
}

void _onNetworkServerList(
    Action action, Context<GatewayProfileState> ctx) async {
  final loading = Loading.show(ctx.context);

  NetworkServerDao dao = _buildNetworkServerDao(ctx);
  String orgId = ctx.context.read<SupernodeCubit>().state.orgId;

  if (orgId.isEmpty) {
    try {
      await _getOrganizations(action, ctx);
    } finally {
      loading.hide();
    }
    return;
  }

  Map data = {"organizationID": orgId, "offset": 0, "limit": 999};

  await dao.list(data).then((res) {
    loading.hide();
    mLog('NetworkServerDao list', res);

    if ((res as Map).containsKey('result') && res['result'].length > 0) {
      // List nsList = [];

      // nsList = res['result'] as List;
      ctx.dispatch(
          GatewayProfileActionCreator.networkServerList(res['result']));
    }
  }).catchError((err) {
    loading.hide();
    // tip(ctx.context,'NetworkServerDao list: $err');
  });
}
