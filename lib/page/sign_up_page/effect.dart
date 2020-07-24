import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

import 'action.dart';
import 'state.dart';

Effect<SignUpState> buildEffect() {
  return combineEffects(<Object, Effect<SignUpState>>{
    SignUpAction.onEmailContinue: _onEmailContinue,
    SignUpAction.onVerificationContinue: _onVerificationContinue,
    SignUpAction.onRegistrationContinue: _onRegistrationContinue,
  });
}

void _onEmailContinue(Action action, Context<SignUpState> ctx) {
  var curState = ctx.state;
  if((curState.emailFormKey.currentState as FormState).validate()){
    showLoading(ctx.context);

    UserDao dao = UserDao();

    String languageCode = FlutterI18n.currentLocale(ctx.context).languageCode;
    String countryCode = FlutterI18n.currentLocale(ctx.context).countryCode;
    if(languageCode.contains('zh')){
      languageCode = '$languageCode$countryCode';
    }

    Map data = {
      "email": curState.emailCtl.text,
      "language": languageCode
    };
    List<String> users=StorageManager.sharedPreferences.getStringList(Config.USER_KEY)??[];
    if(!users.contains( curState.emailCtl.text)){
      users.add( curState.emailCtl.text);
    }
    StorageManager.sharedPreferences.setStringList(Config.USER_KEY, users);
    dao.register(data).then((res){
      hideLoading(ctx.context);
      mLog('register',res);

      Navigator.push(ctx.context,
        MaterialPageRoute(
          maintainState: false,
          fullscreenDialog: false,
          builder:(context){
            return ctx.buildComponent('verification');
          }
        ),
      );
    }).catchError((err, c){
      hideLoading(ctx.context);
      tip(ctx.context, err);
    });
  }

}

void _onVerificationContinue(Action action, Context<SignUpState> ctx) {
  var curState = ctx.state;
  
  if((curState.codesFormKey.currentState as FormState).validate()){
    showLoading(ctx.context);

    List<String> codes = curState.codeListCtls.map((code) => code.text).toList();

    UserDao dao = UserDao();
    Map data = {
      "token": codes.join()
    };

    dao.registerConfirm(data).then((res){
      hideLoading(ctx.context);
      mLog('registerConfirm',res);

      SettingsState settingsData = GlobalStore.store.getState().settings;

      if(settingsData == null){
        settingsData = SettingsState().clone();
      }

      Dao.token = res['jwt'];
      settingsData.token = res['jwt'];
      settingsData.id = res['id'];
      settingsData.isAdmin = res['isAdmin'];
      settingsData.username = res['username'];
      settingsData.usernameCtl.text = res['username'];

      Map userData = {
        "userId": res['id'],
        "email": res['username']
      };

      ctx.dispatch(SignUpActionCreator.registrationContinue(userData));
    
      SettingsDao.updateLocal(settingsData);

      Navigator.push(ctx.context,
        MaterialPageRoute(
          maintainState: false,
          fullscreenDialog: false,
          builder:(context){
            return ctx.buildComponent('registration');
          }
        ),
      );

    }).catchError((err){
      hideLoading(ctx.context);
      // tip(ctx.context,'UserDao registerConfirm: $err');
    });

  }else{
    tip(ctx.context, FlutterI18n.translate(ctx.context, 'invalid verification code'));
  }
}

void _onRegistrationContinue(Action action, Context<SignUpState> ctx) {
  var curState = ctx.state;
  
  if((curState.registerFormKey.currentState as FormState).validate()){

    if(!curState.isCheckTerms){
      return;
    }
    
    showLoading(ctx.context);
    UserDao dao = UserDao();
    Map data = {
      "organizationName": curState.orgCtl.text,
      "organizationDisplayName": curState.displayCtl.text,
      "userId": curState.userId,
      "password": curState.pwdCtl.text
    };

    dao.registerFinish(data).then((res){
      hideLoading(ctx.context);
      mLog('UserDao registerFinish',res);
      Navigator.of(ctx.context).pushNamed('add_gateway_page',arguments:{'fromPage': 'registration'});
    }).catchError((err){
      hideLoading(ctx.context);
      // tip(ctx.context,'UserDao registerFinish: $err');
    });
  }
}