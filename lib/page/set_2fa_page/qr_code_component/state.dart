import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/page/sign_up_page/registration_component/state.dart';

class QRCodeState implements Cloneable<QRCodeState> {

  GlobalKey formKey = GlobalKey<FormState>();
  bool isEnabled;
  String url = '';
  String secret = '';
  List<dynamic> recoveryCode = [];
  String title = '';
  String qrCode = '';

  @override
  QRCodeState clone() {
    return QRCodeState()
      ..formKey = formKey
      ..isEnabled = isEnabled
      ..url = url
      ..secret = secret
      ..recoveryCode = recoveryCode
      ..title = title
      ..qrCode = qrCode;
  }
}

QRCodeState initState(Map<String, dynamic> args) {
  return QRCodeState();
}
