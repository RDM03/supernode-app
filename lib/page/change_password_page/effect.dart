import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/global_store/store.dart';

import 'action.dart';
import 'state.dart';

Effect<ChangePasswordState> buildEffect() {
  return combineEffects(<Object, Effect<ChangePasswordState>>{
    ChangePasswordAction.onConfirm: _onConfirm,
  });
}

void _onConfirm(Action action, Context<ChangePasswordState> ctx) async {
  var curState = ctx.state;

  if (!(curState.formKey.currentState as FormState).validate()) {
    return;
  }

  String userId = GlobalStore.store.getState().settings.userId;
  String confirmNewPwd = curState.confirmNewPwdCtl.text;

  final loading = await Loading.show(ctx.context);

  Map data = {"userId": userId, "password": confirmNewPwd};

  UserDao dao = UserDao();

  dao.changePassword(data).then((res) {
    mLog('changePassword', res);
    loading.hide();

    tip(ctx.context,
        FlutterI18n.translate(ctx.context, 'updated_successful_tip'),
        success: true);
  }).catchError((err) {
    loading.hide();
    // tip(ctx.context,'UserDao changePassword: $err');
  });
}
