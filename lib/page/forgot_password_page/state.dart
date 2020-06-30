import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:supernodeapp/page/forgot_password_page/password_reset_component/state.dart';

class ForgotPasswordState implements Cloneable<ForgotPasswordState> {
  GlobalKey emailFormKey = GlobalKey<FormState>();
  GlobalKey codesFormKey = GlobalKey<FormState>();

  List<TextEditingController> codeListCtls = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()];

  TextEditingController emailCtl = TextEditingController();
  TextEditingController newPwdCtl = TextEditingController();
  TextEditingController confirmNewPwdCtl = TextEditingController();

  String email = '';
  bool isObscureConPWDText = true;
  bool isObscureNewPWDText = true;

  @override
  ForgotPasswordState clone() {
    return ForgotPasswordState()
      ..emailFormKey = emailFormKey
      ..codesFormKey = codesFormKey
      ..codeListCtls = codeListCtls
      ..emailCtl = emailCtl
      ..newPwdCtl = newPwdCtl
      ..confirmNewPwdCtl = confirmNewPwdCtl
      ..email = email
      ..isObscureNewPWDText = isObscureNewPWDText
      ..isObscureConPWDText = isObscureConPWDText;
  }
}

ForgotPasswordState initState(Map<String, dynamic> args) {
  return ForgotPasswordState();
}

class PasswordResetConnector extends ConnOp<ForgotPasswordState, PasswordResetState> {
  @override
  PasswordResetState get(ForgotPasswordState state) {
    return PasswordResetState()
      ..formKey = state.codesFormKey
      ..listCtls = state.codeListCtls
      ..newPwdCtl = state.newPwdCtl
      ..confirmNewPwdCtl = state.confirmNewPwdCtl
      ..isObscureConPWDText = state.isObscureConPWDText
      ..isObscureNewPWDText = state.isObscureNewPWDText;
  }

  @override
  void set(ForgotPasswordState state, PasswordResetState subState) {
    state
      ..codesFormKey = subState.formKey
      ..codeListCtls = subState.listCtls
      ..isObscureConPWDText = subState.isObscureConPWDText
      ..isObscureNewPWDText = subState.isObscureNewPWDText;
  }
}
