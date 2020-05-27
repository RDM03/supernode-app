import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'action.dart';
import 'state.dart';

Effect<Set2FAState> buildEffect() {
  return combineEffects(<Object, Effect<Set2FAState>>{
    Lifecycle.initState: _initState,
    Set2FAAction.onConfirm: _onConfirm,
  });
}

void _initState(Action action, Context<Set2FAState> ctx) {
  var curState = ctx.state;
print(123);
  //Map data = {
  //  'username': curState.usernameCtl.text.trim(),
  //  'password': curState.passwordCtl.text.trim()
  //};

  UserDao dao = UserDao();
  // var response = await dao.login(data);



  dao.getTOTPStatus().then((res){
    log('totp',res);
    print('start');
    print(res);
    print('start');
    //hideLoading(ctx.context);

    if((res as Map).containsKey('isEnabled')){
      ctx.dispatch(Set2FAActionCreator.isEnabled(res['enabled']));
    }

    //Navigator.pushNamedAndRemoveUntil(ctx.context,'home_page',(route) => false,arguments:{'superNode':curState.selectedSuperNode});

  }).catchError((err){
    hideLoading(ctx.context);
    tip(ctx.context,'$err');
  });

}


void _onConfirm(Action action, Context<Set2FAState> ctx) {
  var curState = ctx.state;

  if(!(curState.formKey.currentState as FormState).validate()){
    return;
  }

  String userId = GlobalStore.store.getState().settings.userId;
  bool isEnabled = curState.isEnabled;

  showLoading(ctx.context);

  Map data = {
    "userId": userId,
  };

  UserDao dao = UserDao();

  dao.changePassword(data).then((res){
    log('changePassword',res);
    hideLoading(ctx.context);

    tip(ctx.context,'Updated Successfully',success: true);

  }).catchError((err){
    hideLoading(ctx.context);
    tip(ctx.context,'UserDao changePassword: $err');
  });
}
