import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/page/sign_up_page/registration_component/state.dart';

class RecoveryCodeState implements Cloneable<RecoveryCodeState> {

  GlobalKey formKey = GlobalKey<FormState>();
  List<dynamic> recoveryCode = [];
  bool isAgreed;
  
  @override
  RecoveryCodeState clone() {
    return RecoveryCodeState()
      ..formKey = formKey
      ..isAgreed = isAgreed
      ..recoveryCode = recoveryCode;
  }
}

RecoveryCodeState initState(Map<String, dynamic> args) {
  return RecoveryCodeState();
}
