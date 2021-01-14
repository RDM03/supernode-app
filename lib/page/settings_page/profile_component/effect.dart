import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/auth.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/global_store/store.dart';

import 'action.dart';
import 'state.dart';

Effect<ProfileState> buildEffect() {
  return combineEffects(<Object, Effect<ProfileState>>{
    ProfileAction.onUpdate: _onUpdate,
    ProfileAction.onUnbind: _onUnbind,
  });
}

void _onUpdate(Action action, Context<ProfileState> ctx) async {
  var curState = ctx.state;

  if ((curState.formKey.currentState as FormState).validate()) {
    final loading = await Loading.show(ctx.context);
    String username = curState.usernameCtl.text;
    String email = curState.emailCtl.text;

    Map data = {
      "id": curState.userId,
      "username": username,
      "email": email,
      "sessionTTL": 0,
      "isAdmin": true,
      "isActive": true,
      "note": ""
    };

    UserDao dao = UserDao();

    dao.update({"user" : data}).then((res) {
      mLog('update', res);

      String jwt = res['jwt'];
      if (jwt != null && jwt.isNotEmpty) {
        saveLoginResult(dao, jwt, username, StorageManager.sharedPreferences.getString(Config.PASSWORD_KEY), StorageManager.sharedPreferences.getString(Config.API_ROOT));
        ctx.dispatch(ProfileActionCreator.jwtUpdate(data));
      }
      loading.hide();
      Navigator.of(ctx.context).pop();
    }).catchError((err) {
      loading.hide();
      tip(ctx.context,'UserDao update: $err');
    });
  }
}

void _onUnbind(Action action, Context<ProfileState> ctx) async {
  ctx.dispatch(ProfileActionCreator.showConfirmation(false));
  final loading = await Loading.show(ctx.context);

  Map data = {
    "organizationId": GlobalStore.store.getState().settings.selectedOrganizationId,
    "service": "wechat"
  };

  UserDao dao = UserDao();

  dao.unbindExternalUser(data).then((res) {
    loading.hide();
    ctx.dispatch(ProfileActionCreator.unbind());
  }).catchError((err) {
    loading.hide();
    tip(ctx.context,'Unbind: $err');
  });
}
