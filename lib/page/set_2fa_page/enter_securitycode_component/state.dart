import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/page/sign_up_page/registration_component/state.dart';

class EnterSecurityCodeState implements Cloneable<EnterSecurityCodeState> {

  GlobalKey formKey = GlobalKey<FormState>();
  bool isEnabled;
  List<TextEditingController> listCtls = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];


  @override
  EnterSecurityCodeState clone() {
    return EnterSecurityCodeState()
      ..formKey = formKey
      ..isEnabled = isEnabled
      ..listCtls = listCtls;
  }
}

EnterSecurityCodeState initState(Map<String, dynamic> args) {
  return EnterSecurityCodeState();
}
