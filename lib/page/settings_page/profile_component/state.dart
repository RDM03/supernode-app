import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

class ProfileState implements Cloneable<ProfileState> {

  TextEditingController usernameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController shopifyEmailCtl = TextEditingController();
  TextEditingController shopifyVerificationCodeCtl = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();

  String userId = '';
  String username = '';
  String email = '';
  bool reloadProfile = false;
  String wechatExternalUsername = '';
  String shopifyExternalUsername = '';
  bool isAdmin = false;
  bool showWechatUnbindConfirmation = false;
  int showBindShopifyStep = 0;

  @override
  ProfileState clone() {
    return ProfileState()
      ..userId = userId
      ..username = username
      ..email = email
      ..reloadProfile = reloadProfile
      ..usernameCtl = usernameCtl
      ..emailCtl = emailCtl
      ..shopifyEmailCtl = shopifyEmailCtl
      ..shopifyVerificationCodeCtl = shopifyVerificationCodeCtl
      ..wechatExternalUsername = wechatExternalUsername
      ..shopifyExternalUsername = shopifyExternalUsername
      ..isAdmin = isAdmin
      ..showWechatUnbindConfirmation = showWechatUnbindConfirmation
      ..showBindShopifyStep = showBindShopifyStep;
  }
}

ProfileState initState(Map<String, dynamic> args) {
  return ProfileState();
}
