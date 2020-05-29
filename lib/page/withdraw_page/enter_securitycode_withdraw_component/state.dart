import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/page/sign_up_page/registration_component/state.dart';

class EnterSecurityCodeWithdrawState implements Cloneable<EnterSecurityCodeWithdrawState> {

  GlobalKey formKey = GlobalKey<FormState>();
  bool isEnabled;
  List<TextEditingController> listCtls = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  EnterSecurityCodeWithdrawState clone() {
    return EnterSecurityCodeWithdrawState()
      ..formKey = formKey
      ..isEnabled = isEnabled
      ..listCtls = listCtls;
  }
}

EnterSecurityCodeWithdrawState initState(Map<String, dynamic> args) {
  return EnterSecurityCodeWithdrawState();
}
