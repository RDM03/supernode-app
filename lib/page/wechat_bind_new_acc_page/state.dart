import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class WechatBindNewAccState implements Cloneable<WechatBindNewAccState> {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController orgCtl = TextEditingController();
  TextEditingController displayCtl = TextEditingController();
  bool isCheckTerms = false;
  bool isCheckSend = false;

  @override
  WechatBindNewAccState clone() {
    return WechatBindNewAccState()
      ..formKey = formKey
      ..emailCtl = emailCtl
      ..orgCtl = orgCtl
      ..displayCtl = displayCtl
      ..isCheckTerms = isCheckTerms
      ..isCheckSend = isCheckSend;
  }
}

WechatBindNewAccState initState(Map<String, dynamic> args) {
  return WechatBindNewAccState();
}