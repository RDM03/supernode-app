import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/configs/config.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/configs/sys.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/global_store/action.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/home_page/user_component/state.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'action.dart';

Effect<UserState> buildEffect() {
  return combineEffects(<Object, Effect<UserState>>{
    LoginAction.onLogin: _onLogin,
    LoginAction.onSignUp: _onSignUp,
    LoginAction.onForgotPassword: _onForgotPassword,
  });
}

void _onLogin(Action action, Context<UserState> ctx) async{
  var curState = ctx.state;

  if(curState.selectedSuperNode.isEmpty){
    tip(ctx.context,FlutterI18n.translate(ctx.context,'reg_select_supernode'));
    return;
  }

  if((curState.formKey.currentState as FormState).validate()){
    showLoading(ctx.context);
    
    Map data = {
      'username': curState.usernameCtl.text.trim(),
      'password': curState.passwordCtl.text.trim()
    };

    String apiRoot = Sys.superNodes[curState.selectedSuperNode];
    Dao.baseUrl = apiRoot;

    UserDao dao = UserDao();
    // var response = await dao.login(data);

    dao.login(data).then((res){
      log('login',res);
      hideLoading(ctx.context);

      SettingsState settingsData = GlobalStore.store.getState().settings;

      if(settingsData == null){
        settingsData = SettingsState().clone();
      }

      Dao.token = res['jwt'];
      settingsData.token = res['jwt'];
      settingsData.username = data['username'];
      settingsData.superNode = curState.selectedSuperNode;
      List<String> users=StorageManager.sharedPreferences.getStringList(Config.USER_KEY)??[];
      if(!users.contains(data['username'])){
        users.add(data['username']);
      }
      StorageManager.sharedPreferences.setStringList(Config.USER_KEY, users);
      StorageManager.sharedPreferences.setString(Config.USERNAME_KEY, data['username']);
      StorageManager.sharedPreferences.setString(Config.PASSWORD_KEY, data['password']);
      StorageManager.sharedPreferences.setString(Config.API_ROOT, apiRoot);
      GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));

      Navigator.pushNamedAndRemoveUntil(ctx.context,'home_page',(route) => false,arguments:{'superNode':curState.selectedSuperNode});

    }).catchError((err){
      hideLoading(ctx.context);
      tip(ctx.context,'$err');
    });

  }
}

void _onSignUp(Action action, Context<UserState> ctx) {
  var curState = ctx.state;
  if(curState.selectedSuperNode.isEmpty){
    tip(ctx.context,FlutterI18n.translate(ctx.context,'reg_select_supernode'));
    return;
  }

  String apiRoot = Sys.superNodes[curState.selectedSuperNode];
  Dao.baseUrl = apiRoot;

  SettingsState settingsData = GlobalStore.store.getState().settings;

  if(settingsData == null){
    settingsData = SettingsState().clone();
  }

  settingsData.superNode = curState.selectedSuperNode;
  
  GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));

  Navigator.pushNamed(ctx.context, 'sign_up_page');
}

void _onForgotPassword(Action action, Context<UserState> ctx) {
  Navigator.pushNamed(ctx.context, 'forgot_password_page');
}