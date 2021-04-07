import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/map_box.dart';

class GatewayProfileState implements Cloneable<GatewayProfileState> {
  TextEditingController networkCtl = TextEditingController();
  TextEditingController gatewayProfileCtl = TextEditingController();
  TextEditingController nameCtl = TextEditingController();
  TextEditingController descriptionCtl = TextEditingController();
  TextEditingController idCtl = TextEditingController();
  TextEditingController altitudeCtl = TextEditingController();

  //map
  GlobalKey formKey = GlobalKey<FormState>();
  MapViewController mapCtl;
  bool isSelectIdType = true;
  // LatLng gatewayPosition;

  String serialNumber = '';
  List networkServerList = [];
  List gatewayProfileList = [];
  String networkServerID = '';
  String gatewayProfileID = '';
  bool discoveryEnabled = true;
  // List<Marker> markers = [];
  LatLng location;
  LatLng markerPoint;

  @override
  GatewayProfileState clone() {
    return GatewayProfileState()
      ..formKey = formKey
      ..serialNumber = serialNumber
      ..networkServerList = networkServerList
      ..gatewayProfileList = gatewayProfileList
      ..networkServerID = networkServerID
      ..gatewayProfileID = gatewayProfileID
      ..networkCtl = networkCtl
      ..gatewayProfileCtl = gatewayProfileCtl
      ..nameCtl = nameCtl
      ..descriptionCtl = descriptionCtl
      ..idCtl = idCtl
      ..altitudeCtl = altitudeCtl
      ..mapCtl = mapCtl
      ..isSelectIdType = isSelectIdType
      ..location = location
      ..markerPoint = markerPoint;
  }
}

GatewayProfileState initState(Map<String, dynamic> args) {
  return GatewayProfileState();
}
