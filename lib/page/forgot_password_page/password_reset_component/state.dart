import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

class PasswordResetState implements Cloneable<PasswordResetState> {
  GlobalKey formKey = GlobalKey<FormState>();
  List<TextEditingController> listCtls = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  TextEditingController newPwdCtl = TextEditingController();
  TextEditingController confirmNewPwdCtl = TextEditingController();
  bool isObscureConPWDText = true;
  bool isObscureNewPWDText = true;

  @override
  PasswordResetState clone() {
    return PasswordResetState()
      ..formKey = formKey
      ..listCtls = listCtls
      ..newPwdCtl = newPwdCtl
      ..confirmNewPwdCtl = confirmNewPwdCtl
      ..isObscureNewPWDText = isObscureNewPWDText
      ..isObscureConPWDText = isObscureConPWDText;
  }
}

PasswordResetState initState(Map<String, dynamic> args) {
  return PasswordResetState();
}
