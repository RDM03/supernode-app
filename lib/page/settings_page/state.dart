import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';

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
  int showBindShopifyStep = 0;

  List<UserOrganization> organizations = [];
  bool is2FAEnabled;

  //profile
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController shopifyEmailCtl = TextEditingController();
  GlobalKey profileFormKey = GlobalKey<FormState>();

  // external
  ExternalUser weChatUser;
  ExternalUser shopifyUser;

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
  bool showWechatUnbindConfirmation = false;

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
      ..shopifyEmailCtl = shopifyEmailCtl
      ..profileFormKey = profileFormKey
      ..weChatUser = weChatUser
      ..shopifyUser = shopifyUser
      ..orgFormKey = orgFormKey
      ..selectedOrgId = selectedOrgId
      ..selectedOrgName = selectedOrgName
      ..orgNameCtl = orgNameCtl
      ..orgDisplayCtl = orgDisplayCtl
      ..orgListCtl = orgListCtl
      ..isDemo = isDemo
      ..info = info
      ..showWechatUnbindConfirmation = showWechatUnbindConfirmation;
  }
}

SettingsState initState(Map<String, dynamic> args) {
  SupernodeSession user = args['user'];
  List<UserOrganization> orgs = args['organizations'];
  ExternalUser weChatUser = args['weChatUser'];
  ExternalUser shopifyUser = args['shopifyUser'];
  bool isDemo = args['isDemo'] ?? false;

  return SettingsState()
    ..userId = user.userId.toString()
    ..username = user.username
    ..email = user.username
    ..usernameCtl.text = user.username
    ..emailCtl.text = user.username
    ..isAdmin = orgs.length > 0 && orgs.first.isAdmin
    ..organizations = orgs
    ..isDemo = isDemo
    ..weChatUser = weChatUser
    ..shopifyUser = shopifyUser;
}

class ProfileConnector extends ConnOp<SettingsState, ProfileState> {
  @override
  ProfileState get(SettingsState state) {
    return ProfileState()
      ..userId = state.userId
      ..username = state.username
      ..email = state.email
      ..reloadProfile = state.reloadProfile
      ..weChatUser = state.weChatUser
      ..shopifyUser = state.shopifyUser
      ..isAdmin = state.isAdmin
      ..showWechatUnbindConfirmation = state.showWechatUnbindConfirmation
      ..showBindShopifyStep = state.showBindShopifyStep
      ..usernameCtl = state.usernameCtl
      ..emailCtl = state.emailCtl
      ..shopifyEmailCtl = state.shopifyEmailCtl
      ..formKey = state.profileFormKey;
  }

  @override
  void set(SettingsState state, ProfileState subState) {
    state
      ..username = subState.username
      ..email = subState.email
      ..reloadProfile = subState.reloadProfile
      ..showWechatUnbindConfirmation = subState.showWechatUnbindConfirmation
      ..showBindShopifyStep = subState.showBindShopifyStep
      ..usernameCtl = subState.usernameCtl
      ..weChatUser = subState.weChatUser
      ..emailCtl = subState.emailCtl
      ..shopifyEmailCtl = subState.shopifyEmailCtl;
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