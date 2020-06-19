import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

import 'gateway_profile_component/state.dart';

class AddGatewayState implements Cloneable<AddGatewayState> {

  String fromPage = '';
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController serialNumberCtl = TextEditingController();
  TextEditingController networkCtl = TextEditingController();
  TextEditingController gatewayProfileCtl = TextEditingController();
  TextEditingController nameCtl = TextEditingController();
  TextEditingController descriptionCtl = TextEditingController();
  TextEditingController idCtl = TextEditingController();
  TextEditingController altitudeCtl = TextEditingController();

  GlobalKey gatewayProfileFormKey = GlobalKey<FormState>();
  List networkServerList = [];
  List gatewayProfileList = [];
  bool discoveryEnabled = true;
  List<OrganizationsState> organizations = [];
  MapViewController mapCtl = MapViewController();
  LatLng location;
  LatLng markerPoint;
  String networkServerID = '';
  String gatewayProfileID = '';
  
  @override
  AddGatewayState clone() {
    return AddGatewayState()
      ..fromPage = fromPage
      ..networkServerList = networkServerList
      ..gatewayProfileList = gatewayProfileList
      ..formKey = formKey
      ..gatewayProfileFormKey = gatewayProfileFormKey
      ..serialNumberCtl = serialNumberCtl
      ..networkCtl = networkCtl
      ..gatewayProfileCtl = gatewayProfileCtl
      ..descriptionCtl = descriptionCtl
      ..idCtl = idCtl
      ..discoveryEnabled = discoveryEnabled
      ..altitudeCtl = altitudeCtl
      ..organizations = organizations
      ..mapCtl = mapCtl
      ..location = location
      ..markerPoint = markerPoint
      ..networkServerID = networkServerID
      ..gatewayProfileID = gatewayProfileID;
  }
}

AddGatewayState initState(Map<String, dynamic> args) {
  String fromPage = args['fromPage'];
  LatLng location;
  if(args['location'] != null){
    location = args['location'];
  }
  
  return AddGatewayState()
    ..fromPage = fromPage
    ..location = location;
}

class GatewayProfileConnector extends ConnOp<AddGatewayState,GatewayProfileState>{

  @override
  GatewayProfileState get(AddGatewayState state){
    state.altitudeCtl.text = state.altitudeCtl.text.isNotEmpty ? state.altitudeCtl.text : '0';
    state.descriptionCtl.text = state.descriptionCtl.text.isNotEmpty ? state.descriptionCtl.text : state.serialNumberCtl.text;

    return GatewayProfileState()
      ..formKey = state.gatewayProfileFormKey
      ..serialNumber = state.serialNumberCtl.text
      ..nameCtl.text = state.serialNumberCtl.text
      ..descriptionCtl = state.descriptionCtl
      ..networkCtl = state.networkCtl
      ..gatewayProfileCtl = state.gatewayProfileCtl
      ..idCtl = state.idCtl
      ..discoveryEnabled = state.discoveryEnabled
      ..altitudeCtl = state.altitudeCtl
      ..mapCtl = state.mapCtl
      ..location = state.location
      ..markerPoint = state.markerPoint
      ..networkServerList = state.networkServerList
      ..gatewayProfileList = state.gatewayProfileList
      ..networkServerID = state.networkServerID
      ..gatewayProfileID = state.gatewayProfileID;
  }

  @override
  void set(AddGatewayState state, GatewayProfileState subState) {
    state
      ..mapCtl = subState.mapCtl
      ..descriptionCtl = subState.descriptionCtl
      ..networkCtl = subState.networkCtl
      ..gatewayProfileCtl = subState.gatewayProfileCtl
      ..idCtl = subState.idCtl
      ..altitudeCtl = subState.altitudeCtl
      ..discoveryEnabled = subState.discoveryEnabled
      ..location = subState.location
      ..markerPoint = subState.markerPoint
      ..networkServerList = subState.networkServerList
      ..gatewayProfileList = subState.gatewayProfileList
      ..networkServerID = subState.networkServerID
      ..gatewayProfileID = subState.gatewayProfileID;
  }
}

