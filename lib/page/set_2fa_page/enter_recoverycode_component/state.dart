import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

class EnterRecoveryCodeState implements Cloneable<EnterRecoveryCodeState> {
  GlobalKey formKey = GlobalKey<FormState>();
  bool isEnabled;
  TextEditingController otpCodeCtl = TextEditingController();

  @override
  EnterRecoveryCodeState clone() {
    return EnterRecoveryCodeState()
      ..formKey = formKey
      ..isEnabled = isEnabled
      ..otpCodeCtl = otpCodeCtl;
  }
}

EnterRecoveryCodeState initState(Map<String, dynamic> args) {
  return EnterRecoveryCodeState();
}
