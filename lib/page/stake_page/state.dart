import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

class StakeState implements Cloneable<StakeState> {

  String type = 'stake';
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController amountCtl = TextEditingController();

  List<OrganizationsState> organizations = [];

  bool resSuccess = false;
  
  @override
  StakeState clone() {
    return StakeState()
      ..type = type
      ..formKey = formKey
      ..amountCtl = amountCtl
      ..organizations = organizations
      ..resSuccess = resSuccess;
  }
}

StakeState initState(Map<String, dynamic> args) {
  List<OrganizationsState> organizations = args['organizations'];
  String type = args['type'] ?? 'stake';

  return StakeState()
    ..organizations = organizations
    ..type = type;
}
