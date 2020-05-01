import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class OrganizationsState implements Cloneable<OrganizationsState> {

  String organizationID = '';
  String organizationName = '';
  bool isAdmin = false;
  bool isDeviceAdmin = false;
  bool isGatewayAdmin = false;
  String createdAt = '';
  String updatedAt = '';

  TextEditingController orgNameCtl = TextEditingController();
  TextEditingController orgDisplayCtl = TextEditingController();
  TextEditingController orgListCtl = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();
  List list = [];
  String selectedOrgName = '';
  String selectedOrgId = '';

  OrganizationsState();

  @override
  OrganizationsState clone() {
    return OrganizationsState()
      ..organizationID = organizationID
      ..organizationName = organizationName
      ..isAdmin = isAdmin
      ..isDeviceAdmin = isDeviceAdmin
      ..isGatewayAdmin = isGatewayAdmin
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..list = list
      ..selectedOrgId = selectedOrgId
      ..selectedOrgName = selectedOrgName;
  }

  OrganizationsState.fromMap(Map map) {
    organizationID = map['organizationID'] as String;
    organizationName = map['organizationName'] as String;
    isAdmin = map['isAdmin'] as bool;
    isDeviceAdmin = map['isDeviceAdmin'] as bool;
    isGatewayAdmin = map['isGatewayAdmin'] as bool;
    createdAt = map['createdAt'] as String;
    updatedAt = map['updatedAt'] as String;
  }

  Map<String,dynamic> toMap() {
    var map = <String,dynamic>{
      'organizationID': organizationID,
      'organizationName': organizationName,
      'isAdmin': isAdmin,
      'isDeviceAdmin': isDeviceAdmin,
      'isGatewayAdmin': isGatewayAdmin,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };

    return map;
  }
}

OrganizationsState initState(Map<String, dynamic> args) {
  return OrganizationsState();
}
