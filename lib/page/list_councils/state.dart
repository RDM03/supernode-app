import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/daos/dhx_dao.dart';

class ListCouncilsState implements Cloneable<ListCouncilsState> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool isDemo;
  Set<String> joinedCouncilsId;

  List<Council> allCouncils;
  List<Council> joinedCouncils;
  List<Council> get selectedCouncils => tab == 0 ? joinedCouncils : allCouncils;

  int tab;

  @override
  ListCouncilsState clone() {
    return ListCouncilsState()
      ..scaffoldKey = scaffoldKey
      ..isDemo = isDemo
      ..allCouncils = allCouncils
      ..joinedCouncils = joinedCouncils
      ..tab = tab;
  }
}

ListCouncilsState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;
  Set<String> joinedCouncilsId = args['joinedCouncilsId'] ?? [];

  return ListCouncilsState()
    ..isDemo = isDemo
    ..joinedCouncilsId = joinedCouncilsId
    ..tab = 0;
}
