import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';

import 'about_component/state.dart';
import 'language_component/state.dart';
import 'organizations_component/state.dart';
import 'profile_component/state.dart';
import 'security_component/state.dart';

class SettingsState implements Cloneable<SettingsState> {
  PackageInfo info;
  int cId;
  String id;
  bool notification = false;
  String language = '';
  String userId = '';
  String username = '';
  String email = '';
  bool isAdmin = false;
  int theme = 0;

  String token = '';
  String otpCode = '';
  List<OrganizationsState> organizations = [];
  String selectedOrganizationId = '';
  String expire = '';
  bool is2FAEnabled = false;

  //profile
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  GlobalKey profileFormKey = GlobalKey<FormState>();

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

  bool isDemo = false;

  SettingsState();
  
  @override
  SettingsState clone() {
    return SettingsState()
      ..id = id
      ..userId = userId
      ..username = username
      ..email = email
      ..isAdmin = isAdmin
      ..notification = notification
      ..language = language
      ..theme = theme
      ..token = token
      ..organizations = organizations
      ..selectedOrganizationId = selectedOrganizationId
      ..expire = expire
      ..usernameCtl = usernameCtl
      ..emailCtl = emailCtl
      ..profileFormKey = profileFormKey
      ..orgFormKey = orgFormKey
      ..selectedOrgId = selectedOrgId
      ..selectedOrgName = selectedOrgName
      ..orgNameCtl = orgNameCtl
      ..orgDisplayCtl = orgDisplayCtl
      ..orgListCtl = orgListCtl
      ..isDemo = isDemo
      ..info = info;
  }

  // columns: [cId, notification, superNode, lanuage, userId, theme]

  SettingsState.fromMap(Map map) {
    id = map[SettingsDao.id] as String;
    notification = map[SettingsDao.notification] == 1 ? true : false;
    language = map[SettingsDao.language] as String;
    userId = map[SettingsDao.userId] as String;
    username = map[SettingsDao.username] as String;
    selectedOrganizationId = map[SettingsDao.organizationId] as String;
    expire = map[SettingsDao.expire] as String;
    token = map[SettingsDao.token] as String;
    theme = map[SettingsDao.theme] as int;
  }

  Map<String,dynamic> toMap() {
    var map = <String,dynamic>{
      SettingsDao.id: id,
      SettingsDao.notification: notification ? 1 : 0,
      SettingsDao.language: language,
      SettingsDao.userId: userId,
      SettingsDao.username: username,
      SettingsDao.organizationId: selectedOrganizationId,
      SettingsDao.expire: expire,
      SettingsDao.token: token,
      SettingsDao.theme: theme
    };

    return map;
  }
}

SettingsState initState(Map<String, dynamic> args) {
  Map user = args['user'];
  List<OrganizationsState> orgs = args['organizations'];
  bool isDemo = args['isDemo'] ?? false;

  return SettingsState()
    ..userId = user['userId']
    ..username = user['username']
    ..email = user['email']
    ..usernameCtl.text = user['username']
    ..isAdmin = orgs.length > 0 && orgs.first.isAdmin
    ..organizations = orgs
    ..isDemo = isDemo;
}

class ProfileConnector extends ConnOp<SettingsState, ProfileState>{

  @override
  ProfileState get(SettingsState state){

    return ProfileState()
      ..userId = state.userId
      ..username = state.username
      ..email = state.email
      ..isAdmin = state.isAdmin
      ..usernameCtl = state.usernameCtl
      ..emailCtl = state.emailCtl
      ..formKey = state.profileFormKey;
  }

  @override
  void set(SettingsState state, ProfileState subState) {
    state
      ..username = subState.username
      ..email = subState.email
      ..usernameCtl = subState.usernameCtl
      ..emailCtl = subState.emailCtl;
  }
}

class OrganizationConnector extends ConnOp<SettingsState, OrganizationsState>{

  @override
  OrganizationsState get(SettingsState state){
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

class SecurityConnector extends ConnOp<SettingsState, SecurityState>{

  @override
  SecurityState get(SettingsState state){
    return SecurityState();
  }

  @override
  void set(SettingsState state, SecurityState subState) {
   
  }
}

class LanguageConnector extends ConnOp<SettingsState, LanguageState>{

  @override
  LanguageState get(SettingsState state){
    return LanguageState()
      ..language = state.language;
  }

  @override
  void set(SettingsState state, LanguageState subState) {
    state.language = subState.language;
  }
}

class AboutConnector extends ConnOp<SettingsState, AboutState>{

  @override
  AboutState get(SettingsState state){
    return AboutState()
      ..version = state.version
      ..buildNumber = state.buildNumber
      ..info = state.info;
  }

  @override
  void set(SettingsState state, AboutState subState) {
   state.info = subState.info;
  }
}