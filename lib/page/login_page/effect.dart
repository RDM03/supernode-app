import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/constants.dart';
import 'package:supernodeapp/common/daos/demo/user_dao.dart';
import 'package:supernodeapp/common/utils/auth.dart';
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
    Lifecycle.initState: _initWeChat,
    Lifecycle.dispose: _dispose,
    LoginAction.onLogin: _onLogin,
    LoginAction.onSignUp: _onSignUp,
    LoginAction.onWeChat: _onWeChat,
    LoginAction.onForgotPassword: _onForgotPassword,
    LoginAction.onDemo: _onDemo,
  });
}

Future<void> _handleLoginRequest(
    UserDao dao, String username, String password, String apiRoot) async {
  Map data = {'username': username, 'password': password};

  var loginResult = await dao.login(data);
  mLog('login', loginResult);

  await saveLoginResult(dao, loginResult['jwt'], data['username'], data['password'], apiRoot);
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
    final loading = await Loading.show(ctx.context);
    try {
      String apiRoot = curState.currentSuperNode.url;
      Dao.baseUrl = apiRoot;
      UserDao dao = UserDao();
      final username = curState.usernameCtl.text.trim();
      final password = curState.passwordCtl.text.trim();

      StorageManager.sharedPreferences.setBool(Config.DEMO_MODE, false);
      await _handleLoginRequest(dao, username, password, apiRoot);

      loading.hide();
      Navigator.pushReplacementNamed(ctx.context, 'home_page');
    } catch (err) {
      loading.hide();
      final res = await checkMaintenance();
      if (!res) return;
      ctx.state.scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          err?.message ?? FlutterI18n.translate(ctx.context,'error_tip'),
          style: Theme.of(ctx.context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: errorColor,
      ));
    } finally {
      loading.hide();
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

void _onSignUp(Action action, Context<LoginState> ctx) async {
  var curState = ctx.state;
  if (curState.currentSuperNode == null) {
    tip(ctx.context,
        FlutterI18n.translate(ctx.context, 'reg_select_supernode'));
    return;
  }

  final res = await checkMaintenance(curState.currentSuperNode);
  if (!res) return;

  String apiRoot = curState.currentSuperNode.url;
  Dao.baseUrl = apiRoot;

  SettingsState settingsData = GlobalStore.store.getState().settings;

  if (settingsData == null) {
    settingsData = SettingsState().clone();
  }

  GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));
  await StorageManager.sharedPreferences.setBool(Config.DEMO_MODE, false);

  Navigator.pushNamed(ctx.context, 'sign_up_page');
}

void _onWeChat(Action action, Context<LoginState> ctx) async {
  var curState = ctx.state;
  if (curState.currentSuperNode == null) {
    tip(ctx.context,
        FlutterI18n.translate(ctx.context, 'reg_select_supernode'));
    return;
  }

  final res = await checkMaintenance(curState.currentSuperNode);
  if (!res) return;

  String apiRoot = curState.currentSuperNode.url;
  Dao.baseUrl = apiRoot;

  SettingsState settingsData = GlobalStore.store.getState().settings;

  if (settingsData == null) {
    settingsData = SettingsState().clone();
  }

  GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));
  await StorageManager.sharedPreferences.setBool(Config.DEMO_MODE, false);

  fluwx.sendWeChatAuth(scope: "snsapi_userinfo", state: "wechat_sdk_demo_test");
  //weChatResponseEventHandler defined in _initWeChat
}

void _onForgotPassword(Action action, Context<LoginState> ctx) async {
  if (ctx.state.currentSuperNode == null) {
    tip(ctx.context,
        FlutterI18n.translate(ctx.context, 'reg_select_supernode'));
    return;
  }

  final res = await checkMaintenance(ctx.state.currentSuperNode);
  if (!res) return;

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

void _initWeChat(Action action, Context<LoginState> ctx) async {
  await fluwx.registerWxApi(
      appId: WECHAT_APP_ID,
      doOnAndroid: true,
      doOnIOS: true,
      universalLink: "https://www.mxc.org/mxcdatadash/");
  var wxInstalled = await fluwx.isWeChatInstalled;
  ctx.dispatch(LoginActionCreator.showWeChat(wxInstalled));

  if (wxInstalled) {
    fluwx.weChatResponseEventHandler.distinct((a, b) => a == b).listen((
        res) async {
      if (res is fluwx.WeChatAuthResponse) {
        final loading = await Loading.show(ctx.context);
        try {
          if (res.errCode == 0) {
            UserDao dao = UserDao();
            Map data = {'code': res.code};
            var authWeChatUserRes = await dao.authenticateWeChatUser(data);

            if (authWeChatUserRes['bindingIsRequired']) {
              // bind DataDash and WeChat accounts
              loading.hide();
              Navigator.pushNamed(ctx.context, 'wechat_login_page');
            } else {
              // accounts already bound - proceed with login
              String apiRoot = ctx.state.currentSuperNode.url;

              await saveLoginResult(dao, authWeChatUserRes['jwt'], '', '', apiRoot);

              loading.hide();
              Navigator.pushReplacementNamed(ctx.context, 'home_page');
            }
          } else {
            tip(ctx.context, res.errStr);
          }
        } catch (err) {
          final res = await checkMaintenance();
          loading.hide();
          if (!res) return;
          String msg;
          try {
            msg = err?.message ?? FlutterI18n.translate(ctx.context,'error_tip');
          } catch (e) {
            msg = FlutterI18n.translate(ctx.context,'error_tip');
          }
          ctx.state.scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
              msg,
              style: Theme.of(ctx.context).textTheme.bodyText1.copyWith(color: Colors.white),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: errorColor,
          ));
        } finally {
          loading.hide();
        }
      }
    });
  }
}
