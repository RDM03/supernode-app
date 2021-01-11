import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class ProfileState implements Cloneable<ProfileState> {
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();

  String userId = '';
  String username = '';
  String email = '';
  bool isAdmin = false;

  @override
  ProfileState clone() {
    return ProfileState()
      ..userId = userId
      ..username = username
      ..email = email
      ..isAdmin = isAdmin;
  }
}

ProfileState initState(Map<String, dynamic> args) {
  return ProfileState();
}
