import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:supernodeapp/page/home_page/gateway_component/gateway_list_adapter/gateway_item_component/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<GatewayProfileState> buildReducer() {
  return asReducer(
    <Object, Reducer<GatewayProfileState>>{
      GatewayProfileAction.selectIdType: _selectIdType,
      GatewayProfileAction.updateItem: _updateItem,
      GatewayProfileAction.networkServerList: _networkServerList,
      GatewayProfileAction.gatewayProfileList: _gatewayProfileList,
      GatewayProfileAction.networkServerId: _networkServerId,
      GatewayProfileAction.gatewayProfileId: _gatewayProfileId,
      GatewayProfileAction.discoveryEnabled: _discoveryEnabled,
      GatewayProfileAction.addLocation: _addLocation,
      
    },
  );
}

GatewayProfileState _selectIdType(GatewayProfileState state, Action action) {
  final GatewayProfileState newState = state.clone();
  return newState
    ..isSelectIdType = !state.isSelectIdType;
}

GatewayProfileState _updateItem(GatewayProfileState state, Action action) {
  GatewayItemState data = action.payload;

  final GatewayProfileState newState = state.clone();
  return newState;
    // ..item = data;
}

GatewayProfileState _onSetLocation(GatewayProfileState state, Action action) {
  // LatLng data = action.payload;

  // final GatewayProfileState newState = state.clone();
  // return newState
  //   ..gatewayPosition = data;
}

GatewayProfileState _networkServerList(GatewayProfileState state, Action action) {
  List list = action.payload;

  final GatewayProfileState newState = state.clone();
  return newState
    ..networkServerList = list;
}

GatewayProfileState _gatewayProfileList(GatewayProfileState state, Action action) {
  List list = action.payload;

  final GatewayProfileState newState = state.clone();
  return newState
    ..gatewayProfileList = list;
}

GatewayProfileState _networkServerId(GatewayProfileState state, Action action) {
  Map data = action.payload;
  String id = data['id'];
  String value = data['value'];

  final GatewayProfileState newState = state.clone();
  return newState
    ..networkServerID = id
    ..networkCtl.text = value;
}

GatewayProfileState _gatewayProfileId(GatewayProfileState state, Action action) {
  Map data = action.payload;
  String id = data['id'];
  String value = data['value'];

  final GatewayProfileState newState = state.clone();
  return newState
    ..gatewayProfileID = id
    ..gatewayProfileCtl.text = value;
}

GatewayProfileState _discoveryEnabled(GatewayProfileState state, Action action) {

  final GatewayProfileState newState = state.clone();
  return newState
    ..discoveryEnabled = !state.discoveryEnabled;
}

GatewayProfileState _addLocation(GatewayProfileState state, Action action) {
  LatLng location = action.payload;
  
  final GatewayProfileState newState = state.clone();
  return newState
    ..markerPoint = location;
}