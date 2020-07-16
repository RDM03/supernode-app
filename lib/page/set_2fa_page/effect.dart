import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'package:supernodeapp/global_store/action.dart';

import 'action.dart';
import 'state.dart';

Effect<Set2FAState> buildEffect() {
  return combineEffects(<Object, Effect<Set2FAState>>{
    Lifecycle.initState: _initState,
    Set2FAAction.onEnterSecurityContinue: _onEnterSecurityContinue,
    Set2FAAction.onEnterRecoveryContinue: _onEnterRecoveryContinue,
    Set2FAAction.onQRCodeContinue: _onQRCodeContinue,
    Set2FAAction.onSetEnable: _onSetEnable,
    Set2FAAction.onSetDisable: _onSetDisable,
    Set2FAAction.onRecoveryCodeContinue: _onRecoveryCodeContinue,
    Set2FAAction.onGetTOTPConfig: _onGetTOTPConfig,
  });
}

void _initState(Action action, Context<Set2FAState> ctx) {
  UserDao dao = UserDao();

  Map data = {};

  dao.getTOTPStatus(data).then((res){
    mLog('totp',res);

    if((res as Map).containsKey('enabled')){
     ctx.dispatch(Set2FAActionCreator.isEnabled(res['enabled']));
    }

  }).catchError((err){
    // tip(ctx.context,'$err');
  });

}

void _onQRCodeContinue(Action action, Context<Set2FAState> ctx) async{
  Navigator.push(ctx.context,
    MaterialPageRoute(
        maintainState: false,
        fullscreenDialog: false,
        builder:(context){
          return ctx.buildComponent('qrCode');
        }
    ),
  );
}

void _onEnterSecurityContinue(Action action, Context<Set2FAState> ctx) async{
  Navigator.push(ctx.context,
    MaterialPageRoute(
        maintainState: false,
        fullscreenDialog: false,
        builder:(context){
          return ctx.buildComponent('enterSecurityCode');
        }
    ),
  );
}

void _onEnterRecoveryContinue(Action action, Context<Set2FAState> ctx) async{
  Navigator.push(ctx.context,
    MaterialPageRoute(
        maintainState: false,
        fullscreenDialog: false,
        builder:(context){
          return ctx.buildComponent('enterRecoveryCode');
        }
    ),
  );
}

void _onRecoveryCodeContinue(Action action, Context<Set2FAState> ctx) async{
  var count = 0;
  Navigator.popUntil(ctx.context, (route) {
    return count++ == 4;
  });
}

void _onGetTOTPConfig(Action action, Context<Set2FAState> ctx) {
  var curState = ctx.state;

  if(!(curState.formKey.currentState as FormState).validate()){
    return;
  }

  int qrCodeSize = 240;

  Map data = {
    "qrCodeSize": qrCodeSize,
  };

  UserDao dao = UserDao();

  showLoading(ctx.context);
  dao.getTOTPConfig(data).then((res){
    hideLoading(ctx.context);
    mLog('changePassword',res);

    ctx.dispatch(Set2FAActionCreator.getTOTPConfig({"url": res['url'],"secret": res['secret'], "recoveryCode": res['recoveryCode'], "title":res['title'], "qrCode": res['qrCode']}));

    Navigator.push(ctx.context,
      MaterialPageRoute(
          maintainState: false,
          fullscreenDialog: false,
          builder:(context){
            return ctx.buildComponent('qrCode');
          }
      ),
    );
  }).catchError((err){
    hideLoading(ctx.context);
    // tip(ctx.context,'UserDao getTOTPConfig: $err');
  });
}

void _onSetEnable(Action action, Context<Set2FAState> ctx){
  var curState = ctx.state;

  UserDao dao = UserDao();

  List<String> codes = curState.listCtls.map((code) => code.text).toList();
  SettingsState settingsData = GlobalStore.store.getState().settings;

  if(settingsData == null){
    settingsData = SettingsState().clone();
  }

  settingsData.otp_code = codes.join();

  Map data = {
    "otp_code": codes.join()
  };

  showLoading(ctx.context);
  dao.setEnable(data).then((res){
    hideLoading(ctx.context);
    mLog('setEnable status',res);
    ctx.dispatch(Set2FAActionCreator.isEnabled(true));
  }).then((res){
    hideLoading(ctx.context);
    mLog('login saf',res);
    UserDao dao = UserDao();

    Map data = {};

    showLoading(ctx.context);
    dao.getTOTPStatus(data).then((res){
      hideLoading(ctx.context);
      mLog('totp',res);
      SettingsState settingsData = GlobalStore.store.getState().settings;

      if(settingsData == null){
        settingsData = SettingsState().clone();
      }

      settingsData.is2FAEnabled = res['enabled'];
      if((res as Map).containsKey('enabled')){
        GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));
      }

      Navigator.push(ctx.context,
        MaterialPageRoute(
            maintainState: false,
            fullscreenDialog: false,
            builder:(context){
              return ctx.buildComponent('recoveryCode');
            }
        ),
      );
    }).catchError((err){
      hideLoading(ctx.context);
      // tip(ctx.context,'$err');
    });
  })..catchError((err){
    hideLoading(ctx.context);
    // tip(ctx.context,'Setting setEnable: $err');
  });
}

void _onSetDisable(Action action, Context<Set2FAState> ctx){
  var curState = ctx.state;

  UserDao dao = UserDao();

  String codes = curState.otpCodeCtl.text;
  SettingsState settingsData = GlobalStore.store.getState().settings;

  if(settingsData == null){
    settingsData = SettingsState().clone();
  }

  settingsData.otp_code = codes;

  Map data = {
    "otp_code": codes
  };

  showLoading(ctx.context);
  dao.setDisable(data).then((res){
    hideLoading(ctx.context);
    mLog('setDisable status',res);

    settingsData.is2FAEnabled = false;
    GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));

  }).then((res){
    hideLoading(ctx.context);
    print(res);
    mLog('get 2fa status ',res);
    UserDao dao = UserDao();

    Map data = {};

    showLoading(ctx.context);
    dao.getTOTPStatus(data).then((res){
      hideLoading(ctx.context);
      mLog('totp',res);
      SettingsState settingsData = GlobalStore.store.getState().settings;

      if(settingsData == null){
        settingsData = SettingsState().clone();
      }

      settingsData.is2FAEnabled = res['enabled'];
      if((res as Map).containsKey('enabled')){
        GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));
      }
      var count = 0;
      Navigator.popUntil(ctx.context, (route) {
        print(route);
        return count++ == 2;
      });
    }).catchError((err){
      hideLoading(ctx.context);
      // tip(ctx.context,'$err');
    });
  })..catchError((err){
    hideLoading(ctx.context);
    // tip(ctx.context,'Setting setDisable: $err');
  });
}
