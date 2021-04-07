import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class ChangePasswordState implements Cloneable<ChangePasswordState> {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController oldPwdCtl = TextEditingController();
  TextEditingController newPwdCtl = TextEditingController();
  TextEditingController confirmNewPwdCtl = TextEditingController();
  bool isObscureOldPWDText = true;
  bool isObscureNewPWDText = true;
  bool isObscureConPWDText = true;

  @override
  ChangePasswordState clone() {
    return ChangePasswordState()
      ..formKey = formKey
      ..oldPwdCtl = oldPwdCtl
      ..newPwdCtl = newPwdCtl
      ..confirmNewPwdCtl = confirmNewPwdCtl
      ..isObscureOldPWDText = isObscureOldPWDText
      ..isObscureNewPWDText = isObscureNewPWDText
      ..isObscureConPWDText = isObscureConPWDText;
  }
}

ChangePasswordState initState(Map<String, dynamic> args) {
  return ChangePasswordState();
}
