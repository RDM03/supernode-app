import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';

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
  ExternalUser weChatUser;
  ExternalUser shopifyUser;
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
      ..weChatUser = weChatUser
      ..shopifyEmailCtl = shopifyEmailCtl
      ..shopifyVerificationCodeCtl = shopifyVerificationCodeCtl
      ..isAdmin = isAdmin
      ..showWechatUnbindConfirmation = showWechatUnbindConfirmation
      ..showBindShopifyStep = showBindShopifyStep;
  }
}

ProfileState initState(Map<String, dynamic> args) {
  return ProfileState();
}
