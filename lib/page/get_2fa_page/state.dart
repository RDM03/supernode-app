import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

class Get2FAState implements Cloneable<Get2FAState> {
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

  String title;

  String get otpCode {
    return listCtls.map((e) => e.text).join();
  }

  @override
  Get2FAState clone() {
    return Get2FAState()
      ..title = title
      ..formKey = formKey
      ..isEnabled = isEnabled
      ..listCtls = listCtls;
  }
}

Get2FAState initState(Map<String, dynamic> args) {
  final state = Get2FAState();
  state.title = args != null ? args['title'] : null;
  return state;
}
