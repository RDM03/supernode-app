import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/permission_utils.dart';
import 'package:supernodeapp/common/daos/demo/user_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/data/super_node_bean.dart';
import 'package:supernodeapp/global_store/action.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'action.dart';
import 'state.dart';

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    Lifecycle.dispose: _dispose,
    LoginAction.onLogin: _onLogin,
    LoginAction.onSignUp: _onSignUp,
    LoginAction.onForgotPassword: _onForgotPassword,
    LoginAction.onDemo: _onDemo,
  });
}

Future<void> _handleLoginRequest(
    UserDao dao, String username, String password, String apiRoot) async {
  Map data = {'username': username, 'password': password};
  SettingsState settingsData = GlobalStore.store.getState().settings;

  var loginResult = await dao.login(data);
  mLog('login', loginResult);

  if (settingsData == null) {
    settingsData = SettingsState().clone();
  }

  Dao.token = loginResult['jwt'];
  settingsData.token = loginResult['jwt'];
  settingsData.username = data['username'];
  List<String> users =
      StorageManager.sharedPreferences.getStringList(Config.USER_KEY) ?? [];
  if (!users.contains(data['username'])) {
    users.add(data['username']);
  }
  StorageManager.sharedPreferences.setStringList(Config.USER_KEY, users);
  StorageManager.sharedPreferences
      .setString(Config.TOKEN_KEY, loginResult['jwt']);
  StorageManager.sharedPreferences
      .setString(Config.USERNAME_KEY, data['username']);
  StorageManager.sharedPreferences
      .setString(Config.PASSWORD_KEY, data['password']);
  StorageManager.sharedPreferences.setString(Config.API_ROOT, apiRoot);
  GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));

  var totpStatus = await dao.getTOTPStatus({});
  mLog('totp', totpStatus);

  settingsData.is2FAEnabled = totpStatus['enabled'];
  if ((totpStatus as Map).containsKey('enabled')) {
    GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));
  }
  await PermissionUtil.getLocationPermission();
}

void _onLogin(Action action, Context<LoginState> ctx) async {
  Dao.ctx = ctx;
  var curState = ctx.state;

  if (curState.currentSuperNode == null) {
    tip(ctx.context,
        FlutterI18n.translate(ctx.context, 'reg_select_supernode'));
    return;
  }

  if ((curState.formKey.currentState as FormState).validate()) {
    showLoading(ctx.context);
    try {
      String apiRoot = curState.currentSuperNode.url;
      Dao.baseUrl = apiRoot;
      UserDao dao = UserDao();
      final username = curState.usernameCtl.text.trim();
      final password = curState.passwordCtl.text.trim();

      StorageManager.sharedPreferences.setBool(Config.DEMO_MODE, false);
      await _handleLoginRequest(dao, username, password, apiRoot);

      hideLoading(ctx.context);
      Navigator.pushReplacementNamed(ctx.context, 'home_page');
    } catch (err) {
      ctx.state.scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          err,
          style: Theme.of(ctx.context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: errorColor,
      ));
    } finally {
      hideLoading(ctx.context);
    }
  }
}

void _onDemo(Action action, Context<LoginState> ctx) async {
  final dao = DemoUserDao();
  final username = DemoUserDao.username;

  GlobalStore.store.dispatch(GlobalActionCreator.choiceSuperNode(SuperNodeBean(
    logo: 'https://lora.supernode.matchx.io/branding.png',
    name: 'Demo',
  )));

  await _handleLoginRequest(dao, username, '', 'demo-root');
  await StorageManager.sharedPreferences.setBool(Config.DEMO_MODE, true);
  await StorageManager.sharedPreferences
      .setString(Config.TOKEN_KEY, 'demo-token');

  Navigator.pushReplacementNamed(ctx.context, 'home_page');
}

void _onSignUp(Action action, Context<LoginState> ctx) {
  var curState = ctx.state;
  if (curState.currentSuperNode == null) {
    tip(ctx.context,
        FlutterI18n.translate(ctx.context, 'reg_select_supernode'));
    return;
  }

  String apiRoot = curState.currentSuperNode.url;
  Dao.baseUrl = apiRoot;

  SettingsState settingsData = GlobalStore.store.getState().settings;

  if (settingsData == null) {
    settingsData = SettingsState().clone();
  }

  GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));

  Navigator.pushNamed(ctx.context, 'sign_up_page');
}

void _onForgotPassword(Action action, Context<LoginState> ctx) {
  if (ctx.state.currentSuperNode == null) {
    tip(ctx.context,
        FlutterI18n.translate(ctx.context, 'reg_select_supernode'));
    return;
  }

  String apiRoot = ctx.state.currentSuperNode.url;
  Dao.baseUrl = apiRoot;

  SettingsState settingsData = GlobalStore.store.getState().settings;

  if (settingsData == null) {
    settingsData = SettingsState().clone();
  }

  GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));
  Navigator.of(ctx.context).pushNamed("forgot_password_page");
}

void _dispose(Action action, Context<LoginState> ctx) {
  ctx.state.passwordCtl?.dispose();
  ctx.state.usernameCtl?.dispose();
}
