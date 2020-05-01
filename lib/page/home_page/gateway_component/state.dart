import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

import 'gateway_list_adapter/gateway_item_component/state.dart';

class GatewayState extends MutableSource implements Cloneable<GatewayState> {

  GlobalKey addFormKey = GlobalKey<FormState>();
  TextEditingController serialNumberCtl = TextEditingController();
  TextEditingController networkCtl = TextEditingController();
  TextEditingController gatewayProfileCtl = TextEditingController();
  TextEditingController nameCtl = TextEditingController();
  TextEditingController descriptionCtl = TextEditingController();
  TextEditingController idCtl = TextEditingController();
  TextEditingController altitudeCtl = TextEditingController();
  
  //gateways
  int gatewaysTotal = 0;
  double gatewaysRevenue = 0;
  double gatewaysUSDRevenue = 0;

  GlobalKey gatewayProfileFormKey = GlobalKey<FormState>();
  List networkServerList = [];
  List gatewayProfileList = [];
  bool discoveryEnabled = true;
  MapController mapCtl = MapController();
  LatLng location;
  LatLng markerPoint;
  String networkServerID = '';
  String gatewayProfileID = '';

  //profile
  // MapController mapCtl = MapController();
  // bool isSelectIdType = true;

  List<OrganizationsState> organizations = [];

  List list = [];

  @override
  Object getItemData(int index) => list[index];

  @override
  String getItemType(int index) => 'item';

  @override
  int get itemCount => list?.length ?? 0;

  @override
  void setItemData(int index, Object data) => list[index] = data;

  @override
  GatewayState clone() {
    return GatewayState()
      ..addFormKey = addFormKey
      ..serialNumberCtl = serialNumberCtl
      ..networkCtl = networkCtl
      ..gatewayProfileCtl = gatewayProfileCtl
      ..nameCtl = nameCtl
      ..descriptionCtl = descriptionCtl
      ..idCtl = idCtl
      ..altitudeCtl = altitudeCtl 
      ..gatewaysTotal = gatewaysTotal
      ..gatewaysRevenue = gatewaysRevenue
      ..gatewaysUSDRevenue = gatewaysUSDRevenue
      ..list = list ?? []
      ..discoveryEnabled = discoveryEnabled
      ..mapCtl = mapCtl
      ..location = location
      ..markerPoint = markerPoint
      ..gatewayProfileFormKey = gatewayProfileFormKey
      ..networkServerList = networkServerList
      ..gatewayProfileList = gatewayProfileList
      ..networkServerID = networkServerID
      ..gatewayProfileID = gatewayProfileID;
  }
}

GatewayState initState(Map<String, dynamic> args) {
  return GatewayState();
}

class GatewayItemConnector extends ConnOp<GatewayState, GatewayItemState>{

  @override
  GatewayItemState get(GatewayState state){
    return GatewayItemState();
      // ..mapCtl = state.mapCtl;
      // ..isSelectIdType = state.isSelectIdType;
  }

  @override
  void set(GatewayState state, GatewayItemState subState) {
    // state
      // ..mapCtl = subState.mapCtl;
    // state.isSelectIdType = subState.isSelectIdType;
  }
}

// class AddGatewayConnector extends ConnOp<GatewayState, AddGatewayState>{

//   @override
//   AddGatewayState get(GatewayState state){
//     return AddGatewayState()
//       ..fromPage = 'home'
//       ..formKey = state.addFormKey
//       ..serialNumberCtl = state.serialNumberCtl
//       ..networkCtl = state.networkCtl
//       ..gatewayProfileCtl = state.gatewayProfileCtl
//       // ..nameCtl = state.nameCtl
//       ..descriptionCtl = state.descriptionCtl
//       ..idCtl = state.idCtl
//       ..altitudeCtl = state.altitudeCtl
//       ..discoveryEnabled = state.discoveryEnabled
//       ..organizations = state.organizations
//       ..mapCtl = state.mapCtl
//       ..location = state.location
//       ..markerPoint = state.markerPoint
//       ..gatewayProfileFormKey = state.gatewayProfileFormKey
//       ..networkServerList = state.networkServerList
//       ..gatewayProfileList = state.gatewayProfileList
//       ..networkServerID = state.networkServerID
//       ..gatewayProfileID = state.gatewayProfileID;
//   }

//   @override
//   void set(GatewayState state, AddGatewayState subState) {
//     state
//       ..addFormKey = subState.formKey
//       ..serialNumberCtl = subState.serialNumberCtl
//       ..networkCtl = subState.networkCtl
//       ..gatewayProfileCtl = subState.gatewayProfileCtl
//       // ..nameCtl = subState.nameCtl
//       ..descriptionCtl = subState.descriptionCtl
//       ..idCtl = subState.idCtl
//       ..altitudeCtl = subState.altitudeCtl
//       ..discoveryEnabled = subState.discoveryEnabled
//       ..location = subState.location
//       ..markerPoint = subState.markerPoint
//       ..networkServerList = subState.networkServerList
//       ..gatewayProfileList = subState.gatewayProfileList
//       ..networkServerID = subState.networkServerID
//       ..gatewayProfileID = subState.gatewayProfileID;
//   }
// }