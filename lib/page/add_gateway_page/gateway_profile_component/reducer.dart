import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
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
      GatewayProfileAction.addMapController: _addMapController,
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
  Map data = action.payload;
  LatLng location = data['location'];
  String type = data['type'];
  
  final GatewayProfileState newState = state.clone();
  if(type == 'user'){
    return newState
      ..location = location;
  }else{
    return newState
      ..markerPoint = location;
  }
}
GatewayProfileState _addMapController(GatewayProfileState state, Action action) {
  var newState = state.clone();
  newState.mapCtl = action.payload;
  return newState;
}