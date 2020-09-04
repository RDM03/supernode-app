import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/address_entity.dart';

class AddressDetailsState implements Cloneable<AddressDetailsState> {
  AddressEntity entity;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  AddressDetailsState clone() {
    return AddressDetailsState()
      ..entity = entity
      ..scaffoldKey = scaffoldKey;
  }
}

AddressDetailsState initState(Map<String, dynamic> args) {
  return AddressDetailsState()..entity = AddressEntity.fromMap(args['entity']);
}
