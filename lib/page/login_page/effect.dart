import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/common/daos/supernode_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/global_store/action.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'action.dart';
import 'state.dart';

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    Lifecycle.initState: _initState,
    LoginAction.onLogin: _onLogin,
    LoginAction.onSignUp: _onSignUp,
    LoginAction.onForgotPassword: _onForgotPassword,
  });
}

void _initState(Action action, Context<LoginState> ctx) async {
  var json = await SuperNodeDao().superNodes();
  if (json is Map<String, dynamic>) {
    var superNodes = Map<String, List<dynamic>>();
    for (var key in json.keys) {
      json[key]["name"] = key;
      if (superNodes.containsKey(json[key]["region"]))
        superNodes[json[key]["region"]].add(json[key]);
      else
        superNodes[json[key]["region"]] = [json[key]];
    }
    ctx.dispatch(LoginActionCreator.setSuperNodes(superNodes));
  }
}

void _onLogin(Action action, Context<LoginState> ctx) async {
  var curState = ctx.state;

  if (curState.currentSuperNode != null) {
    tip(ctx.context, FlutterI18n.translate(ctx.context, 'reg_select_supernode'));
    return;
  }

  if ((curState.formKey.currentState as FormState).validate()) {
    showLoading(ctx.context);

    Map data = {'username': curState.usernameCtl.text.trim(), 'password': curState.passwordCtl.text.trim()};

    String apiRoot = curState.currentSuperNode.url;
    Dao.baseUrl = apiRoot;

    UserDao dao = UserDao();
    // var response = await dao.login(data);

    dao.login(data).then((res) {
      mLog('login', res);
      hideLoading(ctx.context);

      SettingsState settingsData = GlobalStore.store.getState().settings;

      if (settingsData == null) {
        settingsData = SettingsState().clone();
      }

      Dao.token = res['jwt'];
      settingsData.token = res['jwt'];
      settingsData.username = data['username'];
      List<String> users = StorageManager.sharedPreferences.getStringList(Config.USER_KEY) ?? [];
      if (!users.contains(data['username'])) {
        users.add(data['username']);
      }
      StorageManager.sharedPreferences.setStringList(Config.USER_KEY, users);
      StorageManager.sharedPreferences.setString(Config.USERNAME_KEY, data['username']);
      StorageManager.sharedPreferences.setString(Config.PASSWORD_KEY, data['password']);
      StorageManager.sharedPreferences.setString(Config.API_ROOT, apiRoot);
      GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));

      //Navigator.pushNamedAndRemoveUntil(ctx.context,'home_page',(route) => false,arguments:{'superNode':curState.selectedSuperNode});
    }).then((res) {
      print(res);
      mLog('login saf', res);
      UserDao dao = UserDao();

      Map data = {};

      dao.getTOTPStatus(data).then((res) {
        mLog('totp', res);
        //hideLoading(ctx.context);
        SettingsState settingsData = GlobalStore.store.getState().settings;

        if (settingsData == null) {
          settingsData = SettingsState().clone();
        }

        settingsData.is2FAEnabled = res['enabled'];
        if ((res as Map).containsKey('enabled')) {
          GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));
        }
        Navigator.pushNamedAndRemoveUntil(ctx.context, 'home_page', (route) => false, arguments: {'superNode': curState.currentSuperNode});
      }).catchError((err) {
        //hideLoading(ctx.context);
        tip(ctx.context, '$err');
      });
    }).catchError((err) {
      hideLoading(ctx.context);
      tip(ctx.context, '$err');
    });
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
  Navigator.pushNamed(ctx.context, 'forgot_password_page');
}
