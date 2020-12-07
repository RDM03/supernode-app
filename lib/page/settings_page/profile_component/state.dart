import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

class ProfileState implements Cloneable<ProfileState> {

  TextEditingController usernameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();
  //TODO delete SettingsState settingsData = GlobalStore.store.getState().settings;

  String userId = '';
  String username = '';
  String email = '';
  String wechatExternalUsername = '';
  bool isAdmin = false;

  @override
  ProfileState clone() {
    return ProfileState()
      ..userId = userId
      ..username = username
      ..email = email
      ..wechatExternalUsername = wechatExternalUsername
      ..isAdmin = isAdmin;
  }
}

ProfileState initState(Map<String, dynamic> args) {
  return ProfileState();
}
