import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

class StakeState implements Cloneable<StakeState> {

  String type = 'stake';
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController amountCtl = TextEditingController();

  List<OrganizationsState> organizations = [];

  bool resSuccess = false;
  bool isDemo = false;
  bool otpEnabled = false;
  bool inputLocked = false;
  
  @override
  StakeState clone() {
    return StakeState()
      ..type = type
      ..formKey = formKey
      ..amountCtl = amountCtl
      ..organizations = organizations
      ..resSuccess = resSuccess
      ..isDemo = isDemo
      ..otpEnabled = otpEnabled
      ..inputLocked = inputLocked;
  }
}

StakeState initState(Map<String, dynamic> args) {
  List<OrganizationsState> organizations = args['organizations'];
  String type = args['type'] ?? 'stake';
  bool isDemo = args['isDemo'] ?? false;
  bool inputLocked = type == 'unstake';
  double stakedAmount = type == 'unstake' ? args['stakedAmount'] : null;

  return StakeState()
    ..organizations = organizations
    ..type = type
    ..isDemo = isDemo
    ..inputLocked = inputLocked
    ..amountCtl = TextEditingController(text: stakedAmount?.toString());
}
