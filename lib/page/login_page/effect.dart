import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/permission_utils.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/global_store/action.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'action.dart';
import 'state.dart';

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    Lifecycle.dispose: _dispose,
    LoginAction.onLogin: _onLogin,
    LoginAction.onSignUp: _onSignUp,
    LoginAction.onForgotPassword: _onForgotPassword,
  });
}

void _onLogin(Action action, Context<LoginState> ctx) async {
  var curState = ctx.state;

  if (curState.currentSuperNode == null) {
    tip(ctx.context, FlutterI18n.translate(ctx.context, 'reg_select_supernode'));
    return;
  }

  if ((curState.formKey.currentState as FormState).validate()) {
    showLoading(ctx.context);
    try {
      Map data = {'username': curState.usernameCtl.text.trim(), 'password': curState.passwordCtl.text.trim()};
      SettingsState settingsData = GlobalStore.store.getState().settings;
      String apiRoot = curState.currentSuperNode.url;
      Dao.baseUrl = apiRoot;
      UserDao dao = UserDao();

      // var response = await dao.login(data);

      var loginResult = await dao.login(data);
      mLog('login', loginResult);

      if (settingsData == null) {
        settingsData = SettingsState().clone();
      }

      Dao.token = loginResult['jwt'];
      settingsData.token = loginResult['jwt'];
      settingsData.username = data['username'];
      List<String> users = StorageManager.sharedPreferences.getStringList(Config.USER_KEY) ?? [];
      if (!users.contains(data['username'])) {
        users.add(data['username']);
      }
      StorageManager.sharedPreferences.setStringList(Config.USER_KEY, users);
      StorageManager.sharedPreferences.setString(Config.TOKEN_KEY, loginResult['jwt']);
      StorageManager.sharedPreferences.setString(Config.USERNAME_KEY, data['username']);
      StorageManager.sharedPreferences.setString(Config.PASSWORD_KEY, data['password']);
      StorageManager.sharedPreferences.setString(Config.API_ROOT, apiRoot);
      GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));

      var totpStatus = await dao.getTOTPStatus({});
      mLog('totp', totpStatus);

      settingsData.is2FAEnabled = totpStatus['enabled'];
      if ((totpStatus as Map).containsKey('enabled')) {
        GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));
      }
      await PermissionUtil.getLocationPermission();
      hideLoading(ctx.context);
      Navigator.pushReplacementNamed(ctx.context, 'home_page');
    } catch (err) {
      tip(ctx.context, '$err');
    } finally {
      hideLoading(ctx.context);
    }
  }
}

void _onSignUp(Action action, Context<LoginState> ctx) {
  var curState = ctx.state;
  if (curState.currentSuperNode == null) {
    tip(ctx.context, FlutterI18n.translate(ctx.context, 'reg_select_supernode'));
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
    tip(ctx.context, FlutterI18n.translate(ctx.context, 'reg_select_supernode'));
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
