import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

class WithdrawState implements Cloneable<WithdrawState> {

  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController amountCtl = TextEditingController();
  TextEditingController addressCtl = TextEditingController();
  
  double balance = 0;
  List<OrganizationsState> organizations = [];

  @override
  WithdrawState clone() {
    return WithdrawState()
      ..balance = balance
      ..organizations = organizations;
  }
}

WithdrawState initState(Map<String, dynamic> args) {
  double balance = args['balance'];
  List<OrganizationsState> organizations = args['organizations'];

  return WithdrawState()
    ..balance = balance
    ..organizations = organizations;
}