import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'confirm_component/state.dart';
import 'enter_securitycode_withdraw_component/state.dart';

class WithdrawState implements Cloneable<WithdrawState> {
  // why use GlobalKey ? it very expensive !
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController amountCtl = TextEditingController();
  TextEditingController addressCtl = TextEditingController();

  bool status = false;
  bool isEnabled = false;
  double balance = 0;
  double balanceBTC = 0;
  String tokenName = '';
  double fee;
  bool isDemo;

  DateTime confirmTime;

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
      ..balanceBTC = balanceBTC
      ..tokenName = tokenName
      ..fee = fee
      ..isEnabled = isEnabled
      ..listCtls = listCtls
      ..isDemo = isDemo
      ..confirmTime = confirmTime
      ..amountCtl = amountCtl
      ..addressCtl = addressCtl;
  }
}

WithdrawState initState(Map<String, dynamic> args) {
  double balance = args['balance'];
  double balanceBTC = args['balanceBTC'];
  String tokenName = args['tokenName'];
  bool isDemo = args['isDemo'] ?? false;

  return WithdrawState()
    ..balance = balance
    ..balanceBTC = balanceBTC
    ..tokenName = tokenName
    ..isDemo = isDemo;
}

class EnterSecurityCodeWithdrawConnector
    extends ConnOp<WithdrawState, EnterSecurityCodeWithdrawState> {
  @override
  EnterSecurityCodeWithdrawState get(WithdrawState state) {
    return EnterSecurityCodeWithdrawState()
      ..formKey = state.enterSecurityCodeWithdrawFormKey
      ..listCtls = state.listCtls;
  }

  @override
  void set(WithdrawState state, EnterSecurityCodeWithdrawState subState) {
    state..listCtls = subState.listCtls;
  }
}

class ConfirmConnector extends ConnOp<WithdrawState, ConfirmState> {
  @override
  ConfirmState get(WithdrawState state) {
    return ConfirmState()
      ..address = state.addressCtl.text
      ..amount = state.amountCtl.text
      ..tokenName = state.tokenName
      ..confirmTime = state.confirmTime
      ..fee = state.fee.toString()
      ..isEnabled = state.isEnabled;
  }

  @override
  void set(WithdrawState state, ConfirmState subState) {}
}
