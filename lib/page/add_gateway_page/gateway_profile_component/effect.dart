import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:latlong/latlong.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:latlong/latlong.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/select_picker.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/gateways_dao.dart';
import 'package:supernodeapp/common/daos/network_server_dao.dart';
import 'package:supernodeapp/common/daos/organization_dao.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/home_page/action.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
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

void _initState(Action action, Context<GatewayProfileState> ctx) {

  // if(ctx.state.networkServerList.isNotEmpty) return;
  Future.delayed(Duration(seconds: 1),(){
    _onNetworkServerList(action,ctx);

  // if(ctx.state.networkServerID.isNotEmpty){
  //   _gatewayProfile(ctx,ctx.state.networkServerID);
  // }
  });
 
}

void _onNetworkServerPicker(Action action, Context<GatewayProfileState> ctx) {
  var curState = ctx.state;
  int selectedSNIndex = -1;

  List data = curState.networkServerList.asMap().keys.map(
    (index){
      if(curState.networkServerList[index]['id'] == curState.networkServerID){
        selectedSNIndex = index;
      }

      return curState.networkServerList[index]['name'];
    }
  ).toList();

  selectPicker(
    ctx.context,
    data: data,
    value: selectedSNIndex,
    onSelected: (sIndex){
      String id = curState.networkServerList[sIndex]['id'];
      String name = curState.networkServerList[sIndex]['name'];
      ctx.dispatch(GatewayProfileActionCreator.networkServerId(id, name));

      if(ctx.state.gatewayProfileList.isEmpty){
        _gatewayProfile(ctx,id);
      }
      
    }
  );
}

void _onGatewayProfilePicker(Action action, Context<GatewayProfileState> ctx) {
  var curState = ctx.state;
  int selectedIndex = -1;

  List data = curState.gatewayProfileList.asMap().keys.map(
    (index){
      if(curState.gatewayProfileList[index]['id'] == curState.gatewayProfileID){
        selectedIndex = index;
      }

      return curState.gatewayProfileList[index]['name'];
    }
  ).toList();

  selectPicker(
    ctx.context,
    data: data,
    value: selectedIndex,
    onSelected: (sIndex){
      String id = curState.gatewayProfileList[sIndex]['id'];
      String name = curState.gatewayProfileList[sIndex]['name'];
      ctx.dispatch(GatewayProfileActionCreator.gatewayProfileId(id, name));   
    }
  );
}

void _gatewayProfile(Context<GatewayProfileState> ctx,String id){

  GatewaysDao dao = GatewaysDao();

  Map data = {
    "networkServerID": id,
    "offset": 0,
    "limit": 999
  };
  
  dao.profile(data).then((res){
    log('Gateway profile',res);
    if(res.containsKey('result') && res['result'].length > 0){
      ctx.dispatch(GatewayProfileActionCreator.gatewayProfileList(res['result']));
    }else{
      tip(ctx.context,res);
    }
  }).catchError((err){
    tip(ctx.context,'Gateway profile $err');
  });
}

void _update(Action action, Context<GatewayProfileState> ctx) {
  var curState = ctx.state;

  if(curState.networkServerID.isEmpty){
    tip(ctx.context,FlutterI18n.translate(ctx.context,'reg_network_server'));
    return;
  }

  if(curState.gatewayProfileID.isEmpty){
    tip(ctx.context,FlutterI18n.translate(ctx.context,'reg_gateway_profile'));
    return;
  }

  LatLng location = curState.markerPoint ?? curState.location;

  if(location == null){
    tip(ctx.context,FlutterI18n.translate(ctx.context,'reg_gateway_location'));
    return;
  }

  if((curState.formKey.currentState as FormState).validate()){
    showLoading(ctx.context);

    GatewaysDao dao = GatewaysDao();

    String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
    String serialNumber = curState.serialNumber;

    Map data ={
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

    dao.add(data).then((res){
      hideLoading(ctx.context);
      log('GatewaysDao add',res);

      tip(ctx.context,FlutterI18n.translate(ctx.context,'update_success'),success: true);

      Navigator.of(ctx.context).pop();

    }).catchError((err){
      hideLoading(ctx.context);
      tip(ctx.context,'Gateways add: $err');
    });

  }

}

void _getOrganizations(Action action, Context<GatewayProfileState> ctx){
  OrganizationDao dao = OrganizationDao();

  Map data = {
    "offset": 0,
    "limit": 999
  };

  dao.list(data).then((res){
    hideLoading(ctx.context);
    log('OrganizationDao list',res);

    SettingsState settingsData = GlobalStore.store.getState().settings;
    settingsData.selectedOrganizationId = res['result'][0]['id'];
    SettingsDao.updateLocal(settingsData);

    _onNetworkServerList(action,ctx);
    
  }).catchError((err){
    hideLoading(ctx.context);
    tip(ctx.context,'UserDao registerFinish: $err');
  });
}

void _onNetworkServerList(Action action, Context<GatewayProfileState> ctx) async{
  showLoading(ctx.context);
  
  NetworkServerDao dao = NetworkServerDao();
  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;

  if(orgId.isEmpty){
    _getOrganizations(action,ctx);
    return;
  }

  Map data = {
    "organizationID": orgId,
    "offset": 0,
    "limit": 999
  };

  await dao.list(data).then((res){
    hideLoading(ctx.context);
    log('NetworkServerDao list',res);

    if((res as Map).containsKey('result') && res['result'].length > 0){
      // List nsList = [];

      // nsList = res['result'] as List;
      ctx.dispatch(GatewayProfileActionCreator.networkServerList(res['result']));

    }

  }).catchError((err){
    hideLoading(ctx.context);
    ctx.dispatch(HomeActionCreator.loading(false));
    tip(ctx.context,'NetworkServerDao list: $err');
  });

}
