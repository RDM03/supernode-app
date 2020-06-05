import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/page/sign_up_page/registration_component/state.dart';

class EnterRecoveryCodeState implements Cloneable<EnterRecoveryCodeState> {

  GlobalKey formKey = GlobalKey<FormState>();
  bool isEnabled;
  TextEditingController recoveryCodeCtl = TextEditingController();
  @override
  EnterRecoveryCodeState clone() {
    return EnterRecoveryCodeState()
      ..formKey = formKey
      ..isEnabled = isEnabled
      ..recoveryCodeCtl = recoveryCodeCtl;
  }
}

EnterRecoveryCodeState initState(Map<String, dynamic> args) {
  return EnterRecoveryCodeState();
}
