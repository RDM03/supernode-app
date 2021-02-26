import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'registration_component/state.dart';

class SignUpState implements Cloneable<SignUpState> {
  GlobalKey emailFormKey = GlobalKey<FormState>();
  GlobalKey codesFormKey = GlobalKey<FormState>();
  GlobalKey registerFormKey = GlobalKey<FormState>();
  GlobalKey addGatewayFormKey = GlobalKey<FormState>();

  List<TextEditingController> codeListCtls = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  TextEditingController emailCtl = TextEditingController();
  TextEditingController pwdCtl = TextEditingController();
  TextEditingController orgCtl = TextEditingController();
  TextEditingController displayCtl = TextEditingController();
  String userId = '';

  String username;
  String jwtToken;

  bool isCheckTerms = false;
  bool isCheckSend = false;
  bool isObscureText = true;

  @override
  SignUpState clone() {
    return SignUpState()
      ..emailFormKey = emailFormKey
      ..codesFormKey = codesFormKey
      ..registerFormKey = registerFormKey
      ..emailCtl = emailCtl
      ..pwdCtl = pwdCtl
      ..orgCtl = orgCtl
      ..displayCtl = displayCtl
      ..userId = userId
      ..codeListCtls = codeListCtls
      ..isCheckTerms = isCheckTerms
      ..isCheckSend = isCheckSend
      ..isObscureText = isObscureText
      ..username = username
      ..jwtToken = jwtToken;
  }
}

SignUpState initState(Map<String, dynamic> args) {
  return SignUpState();
}

class RegistrationConnector extends ConnOp<SignUpState, RegistrationState> {
  @override
  RegistrationState get(SignUpState state) {
    return RegistrationState()
      ..emailCtl = state.emailCtl
      ..pwdCtl = state.pwdCtl
      ..orgCtl = state.orgCtl
      ..displayCtl = state.displayCtl
      ..userId = state.userId
      ..formKey = state.registerFormKey
      ..isCheckTerms = state.isCheckTerms
      ..isCheckSend = state.isCheckSend
      ..isObscureText = state.isObscureText;
  }

  @override
  void set(SignUpState state, RegistrationState subState) {
    state
      ..pwdCtl = subState.pwdCtl
      ..orgCtl = subState.orgCtl
      ..displayCtl = subState.displayCtl
      ..isCheckTerms = subState.isCheckTerms
      ..isCheckSend = subState.isCheckSend
      ..isObscureText = subState.isObscureText;
  }
}

// class AddGatewayConnector extends ConnOp<SignUpState, AddGatewayState>{

//   @override
//   AddGatewayState get(SignUpState state){
//     return AddGatewayState()
//       ..fromPage = 'registration'
//       ..formKey = state.addGatewayFormKey;
//       // ..serialNumberCtl = state.serialNumberCtl
//       // ..organizations = state.organizations;
//   }

//   @override
//   void set(SignUpState state, AddGatewayState subState) {
//     state
//       // ..serialNumberCtl = subState.serialNumberCtl
//       ..addGatewayFormKey = subState.formKey;
//   }
// }
