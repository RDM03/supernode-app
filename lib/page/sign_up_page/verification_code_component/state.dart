import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

class VerificationCodeState implements Cloneable<VerificationCodeState> {
  GlobalKey formKey = GlobalKey<FormState>();
  List<TextEditingController> listCtls = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  VerificationCodeState clone() {
    return VerificationCodeState()
      ..formKey = formKey
      ..listCtls = listCtls;
  }
}

VerificationCodeState initState(Map<String, dynamic> args) {
  return VerificationCodeState();
}
