import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

class EnterNonOTPSecurityCodeState implements Cloneable<EnterNonOTPSecurityCodeState> {

  GlobalKey formKey = GlobalKey<FormState>();
  bool isEnabled;
  TextEditingController secretCtl = TextEditingController();

  @override
  EnterNonOTPSecurityCodeState clone() {
    return EnterNonOTPSecurityCodeState()
      ..formKey = formKey
      ..isEnabled = isEnabled
      ..secretCtl = secretCtl;
  }
}

EnterNonOTPSecurityCodeState initState(Map<String, dynamic> args) {
  return EnterNonOTPSecurityCodeState();
}
