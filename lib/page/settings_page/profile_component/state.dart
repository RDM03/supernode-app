import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class ProfileState implements Cloneable<ProfileState> {
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();

  String userId = '';
  String username = '';
  String email = '';
  bool reloadProfile = false;
  String wechatExternalUsername = '';
  bool isAdmin = false;
  bool showConfirmation = false;

  @override
  ProfileState clone() {
    return ProfileState()
      ..userId = userId
      ..username = username
      ..email = email
      ..reloadProfile = reloadProfile
      ..usernameCtl = usernameCtl
      ..emailCtl = emailCtl
      ..wechatExternalUsername = wechatExternalUsername
      ..isAdmin = isAdmin
      ..showConfirmation = showConfirmation;
  }
}

ProfileState initState(Map<String, dynamic> args) {
  return ProfileState();
}
