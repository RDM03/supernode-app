import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';
import 'enter_securitycode_withdraw_component/state.dart';

class WithdrawState implements Cloneable<WithdrawState> {

  // why use GlobalKey ? it very expensive !
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController amountCtl = TextEditingController();
  TextEditingController addressCtl = TextEditingController();
  
  bool status = false;
  bool isEnabled = false;
  double balance = 0;
  double fee;
  List<OrganizationsState> organizations = [];
  bool isDemo;

  GlobalKey enterSecurityCodeWithdrawFormKey = GlobalKey<FormState>();
  TextEditingController otpCodeCtl = TextEditingController();
  List<TextEditingController> listCtls = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  WithdrawState clone() {
    return WithdrawState()
      ..status = status
      ..balance = balance
      ..fee = fee
      ..isEnabled = isEnabled
      ..listCtls = listCtls
      ..organizations = organizations
      ..isDemo = isDemo;
  }
}

WithdrawState initState(Map<String, dynamic> args) {
  double balance = args['balance'];
  List<OrganizationsState> organizations = args['organizations'];
  bool isDemo = args['isDemo'] ?? false;

  return WithdrawState()
    ..balance = balance
    ..organizations = organizations
    ..isDemo = isDemo;
}

class EnterSecurityCodeWithdrawConnector extends ConnOp<WithdrawState, EnterSecurityCodeWithdrawState>{

  @override
  EnterSecurityCodeWithdrawState get(WithdrawState state){
    return EnterSecurityCodeWithdrawState()
      ..formKey = state.enterSecurityCodeWithdrawFormKey
      ..listCtls = state.listCtls;
  }

  @override
  void set(WithdrawState state, EnterSecurityCodeWithdrawState subState) {
    state
      ..listCtls = subState.listCtls;
  }
}