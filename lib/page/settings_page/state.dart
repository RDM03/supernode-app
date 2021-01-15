import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';

import 'about_component/state.dart';
import 'language_component/state.dart';
import 'links_component/state.dart';
import 'organizations_component/state.dart';
import 'profile_component/state.dart';
import 'security_component/state.dart';

class SettingsState implements Cloneable<SettingsState> {
  PackageInfo info;
  int cId;
  String id;
  Locale language;
  String userId = '';
  String username = '';
  String email = '';
  bool reloadProfile = false;
  bool isAdmin = false;
  bool showConfirmation = false;

  List<UserOrganization> organizations = [];
  bool is2FAEnabled;

  //profile
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  GlobalKey profileFormKey = GlobalKey<FormState>();

  //external
  String wechatExternalUsername = '';

  //organiztion
  TextEditingController orgNameCtl = TextEditingController();
  TextEditingController orgDisplayCtl = TextEditingController();
  TextEditingController orgListCtl = TextEditingController();
  GlobalKey orgFormKey = GlobalKey<FormState>();
  String selectedOrgName = '';
  String selectedOrgId = '';

  //about
  String version = '';
  String buildNumber = '';
  String mxVersion;

  bool isDemo = false;

  SettingsState();

  @override
  SettingsState clone() {
    return SettingsState()
      ..id = id
      ..userId = userId
      ..username = username
      ..email = email
      ..reloadProfile = reloadProfile
      ..isAdmin = isAdmin
      ..showConfirmation = showConfirmation
      ..language = language
      ..organizations = organizations
      ..usernameCtl = usernameCtl
      ..emailCtl = emailCtl
      ..profileFormKey = profileFormKey
      ..wechatExternalUsername = wechatExternalUsername
      ..orgFormKey = orgFormKey
      ..selectedOrgId = selectedOrgId
      ..selectedOrgName = selectedOrgName
      ..orgNameCtl = orgNameCtl
      ..orgDisplayCtl = orgDisplayCtl
      ..orgListCtl = orgListCtl
      ..isDemo = isDemo
      ..info = info;
  }
}

SettingsState initState(Map<String, dynamic> args) {
  SupernodeSession user = args['user'];
  List<UserOrganization> orgs = args['organizations'];
  bool isDemo = args['isDemo'] ?? false;

  return SettingsState()
    ..userId = user.userId.toString()
    ..username = user.username
    ..email = user.username
    ..usernameCtl.text = user.username
    ..emailCtl.text = user.username
    //..wechatExternalUsername = user['wechatExternalUsername']
    ..isAdmin = orgs.length > 0 && orgs.first.isAdmin
    ..organizations = orgs
    ..isDemo = isDemo;
}

class ProfileConnector extends ConnOp<SettingsState, ProfileState> {
  @override
  ProfileState get(SettingsState state) {
    return ProfileState()
      ..userId = state.userId
      ..username = state.username
      ..email = state.email
      ..reloadProfile = state.reloadProfile
      ..wechatExternalUsername = state.wechatExternalUsername
      ..isAdmin = state.isAdmin
      ..showConfirmation = state.showConfirmation
      ..usernameCtl = state.usernameCtl
      ..emailCtl = state.emailCtl
      ..formKey = state.profileFormKey;
  }

  @override
  void set(SettingsState state, ProfileState subState) {
    state
      ..username = subState.username
      ..email = subState.email
      ..reloadProfile = subState.reloadProfile
      ..showConfirmation = subState.showConfirmation
      ..usernameCtl = subState.usernameCtl
      ..wechatExternalUsername = subState.wechatExternalUsername
      ..emailCtl = subState.emailCtl;
  }
}

class OrganizationConnector extends ConnOp<SettingsState, OrganizationsState> {
  @override
  OrganizationsState get(SettingsState state) {
    return OrganizationsState()
      ..list = state.organizations
      ..formKey = state.orgFormKey
      ..selectedOrgId = state.selectedOrgId
      ..selectedOrgName = state.selectedOrgName
      ..orgNameCtl = state.orgNameCtl
      ..orgDisplayCtl = state.orgDisplayCtl
      ..orgListCtl = state.orgListCtl;
  }

  @override
  void set(SettingsState state, OrganizationsState subState) {
    state
      ..selectedOrgId = subState.selectedOrgId
      ..selectedOrgName = subState.selectedOrgName
      ..orgNameCtl = subState.orgNameCtl
      ..orgDisplayCtl = subState.orgDisplayCtl
      ..orgListCtl = subState.orgListCtl;
  }
}

class SecurityConnector extends ConnOp<SettingsState, SecurityState> {
  @override
  SecurityState get(SettingsState state) {
    return SecurityState();
  }

  @override
  void set(SettingsState state, SecurityState subState) {}
}

class LanguageConnector extends ConnOp<SettingsState, LanguageState> {
  @override
  LanguageState get(SettingsState state) {
    return LanguageState()..language = state.language;
  }

  @override
  void set(SettingsState state, LanguageState subState) {
    state.language = subState.language;
  }
}

class LinksConnector extends ConnOp<SettingsState, LinksState> {
  @override
  LinksState get(SettingsState state) {
    return LinksState();
  }

  @override
  void set(SettingsState state, LinksState subState) {}
}

class AboutConnector extends ConnOp<SettingsState, AboutState> {
  @override
  AboutState get(SettingsState state) {
    return AboutState()
      ..version = state.version
      ..buildNumber = state.buildNumber
      ..info = state.info
      ..mxVersion = state.mxVersion;
  }

  @override
  void set(SettingsState state, AboutState subState) {
    state.info = subState.info;
    state.mxVersion = subState.mxVersion;
  }
}
