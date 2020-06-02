import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'package:supernodeapp/global_store/action.dart';

import 'action.dart';
import 'state.dart';

Effect<Set2FAState> buildEffect() {
  return combineEffects(<Object, Effect<Set2FAState>>{
    Lifecycle.initState: _initState,
    Set2FAAction.onEnterSecurityContinue: _onEnterSecurityContinue,
    Set2FAAction.onQRCodeContinue: _onQRCodeContinue,
    Set2FAAction.onSetEnable: _onSetEnable,
    Set2FAAction.onSetDisable: _onSetDisable,
    Set2FAAction.onRecoveryCodeContinue: _onRecoveryCodeContinue,
    Set2FAAction.onGetTOTPConfig: _onGetTOTPConfig,
    Set2FAAction.onConfirm: _onConfirm,
  });
}

void _initState(Action action, Context<Set2FAState> ctx) {
  var curState = ctx.state;

  UserDao dao = UserDao();

  Map data = {};

  dao.getTOTPStatus(data).then((res){
    log('totp',res);
    //hideLoading(ctx.context);

    if((res as Map).containsKey('enabled')){
     ctx.dispatch(Set2FAActionCreator.isEnabled(res['enabled']));
    }

  }).catchError((err){
    //hideLoading(ctx.context);
    tip(ctx.context,'$err');
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
  //showLoading(ctx.context);

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

void _onRecoveryCodeContinue(Action action, Context<Set2FAState> ctx) async{
  var curState = ctx.state;
  Navigator.pushReplacementNamed(ctx.context, 'set_2fa_page', arguments:{'isEnabled': curState.isEnabled});
}

void _onGetTOTPConfig(Action action, Context<Set2FAState> ctx) {
  var curState = ctx.state;

  if(!(curState.formKey.currentState as FormState).validate()){
    return;
  }

  int qrCodeSize = 240;

  //showLoading(ctx.context);

  Map data = {
    "qrCodeSize": qrCodeSize,
  };

  UserDao dao = UserDao();

  dao.getTOTPConfig(data).then((res){
    log('changePassword',res);
    //hideLoading(ctx.context);

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
    //hideLoading(ctx.context);
    tip(ctx.context,'UserDao getTOTPConfig: $err');
  });
}

void _onSetEnable(Action action, Context<Set2FAState> ctx){
  var curState = ctx.state;

  UserDao dao = UserDao();

  List<String> codes = curState.codeListCtls.map((code) => code.text).toList();
  SettingsState settingsData = GlobalStore.store.getState().settings;

  if(settingsData == null){
    settingsData = SettingsState().clone();
  }

  settingsData.otp_code = codes.join();

  Map data = {
    "opt_code": codes.join()
  };
  //showLoading(ctx.context);
  dao.setEnable(data).then((res){
    //hideLoading(ctx.context);
    log('setEnable status',res);
    ctx.dispatch(Set2FAActionCreator.isEnabled(true));
  }).then((res){
    print(res);
    log('login saf',res);
    UserDao dao = UserDao();

    Map data = {};

    dao.getTOTPStatus(data).then((res){
      log('totp',res);
      //hideLoading(ctx.context);
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
      //hideLoading(ctx.context);
      tip(ctx.context,'$err');
    });
  })..catchError((err){
    //hideLoading(ctx.context);
    tip(ctx.context,'Setting setEnable: $err');
  });
}

void _onSetDisable(Action action, Context<Set2FAState> ctx){
  var curState = ctx.state;

  UserDao dao = UserDao();

  List<String> codes = curState.codeListCtls.map((code) => code.text).toList();
  SettingsState settingsData = GlobalStore.store.getState().settings;

  if(settingsData == null){
    settingsData = SettingsState().clone();
  }

  settingsData.otp_code = codes.join();

  Map data = {
    "opt_code": codes.join()
  };
  //showLoading(ctx.context);
  dao.setDisable(data).then((res){
    //hideLoading(ctx.context);
    log('setDisable status',res);

    settingsData.is2FAEnabled = false;
    GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));

    Navigator.pushReplacementNamed(ctx.context, 'set_2fa_page', arguments:{'isEnabled': curState.isEnabled});
  }).then((res){
    print(res);
    log('login saf',res);
    UserDao dao = UserDao();

    Map data = {};

    dao.getTOTPStatus(data).then((res){
      log('totp',res);
      //hideLoading(ctx.context);
      SettingsState settingsData = GlobalStore.store.getState().settings;

      if(settingsData == null){
        settingsData = SettingsState().clone();
      }

      settingsData.is2FAEnabled = res['enabled'];
      if((res as Map).containsKey('enabled')){
        GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));
      }
      Navigator.pushReplacementNamed(ctx.context, 'set_2fa_page', arguments:{'isEnabled': curState.isEnabled});
    }).catchError((err){
      //hideLoading(ctx.context);
      tip(ctx.context,'$err');
    });
  })..catchError((err){
    //hideLoading(ctx.context);
    tip(ctx.context,'Setting setDisable: $err');
  });
}

void _onConfirm(Action action, Context<Set2FAState> ctx) {
  var curState = ctx.state;

  if(!(curState.formKey.currentState as FormState).validate()){
    return;
  }

  String userId = GlobalStore.store.getState().settings.userId;
  bool isEnabled = curState.isEnabled;

  //showLoading(ctx.context);

  Map data = {
    "userId": userId,
  };

  UserDao dao = UserDao();

  dao.changePassword(data).then((res){
    log('changePassword',res);
    //hideLoading(ctx.context);

    tip(ctx.context,'Updated Successfully',success: true);

  }).catchError((err){
    //hideLoading(ctx.context);
    tip(ctx.context,'UserDao changePassword: $err');
  });
}
