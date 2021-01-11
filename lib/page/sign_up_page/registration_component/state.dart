import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

class RegistrationState implements Cloneable<RegistrationState> {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController pwdCtl = TextEditingController();
  TextEditingController orgCtl = TextEditingController();
  TextEditingController displayCtl = TextEditingController();
  bool isCheckTerms = false;
  bool isCheckSend = false;
  bool isObscureText = true;

  String userId = '';

  @override
  RegistrationState clone() {
    return RegistrationState()
      ..formKey = formKey
      ..emailCtl = emailCtl
      ..pwdCtl = pwdCtl
      ..isObscureText = isObscureText
      ..orgCtl = orgCtl
      ..displayCtl = displayCtl
      ..isCheckTerms = isCheckTerms
      ..isCheckSend = isCheckSend
      ..userId = userId;
  }
}

RegistrationState initState(Map<String, dynamic> args) {
  return RegistrationState();
}
