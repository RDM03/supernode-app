import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class WechatBindState implements Cloneable<WechatBindState> {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  bool isObscureText = true;

  @override
  WechatBindState clone() {
    return WechatBindState()
      ..isObscureText = isObscureText
      ..formKey = formKey
      ..usernameCtl = usernameCtl
      ..passwordCtl = passwordCtl;
  }
}

WechatBindState initState(Map<String, dynamic> args) {
  return WechatBindState();
}