import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
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

    Map data = {
      "id": curState.userId,
      "username": curState.usernameCtl.text,
      "email": curState.emailCtl.text,
      "sessionTTL": 0,
      "isAdmin": true,
      "isActive": true,
      "note": ""
    };

    UserDao dao = UserDao();

    dao.update(data).then((res) {
      mLog('update', res);
      loading.hide();

      ctx.dispatch(ProfileActionCreator.update(data));
    }).catchError((err) {
      loading.hide();
      // tip(ctx.context,'UserDao update: $err');
    });
  }
}

void _onUnbind(Action action, Context<ProfileState> ctx) async {
  final loading = await Loading.show(ctx.context);

  Map data = {
    "organizationId": GlobalStore.store.getState().settings.selectedOrganizationId,
    "service": "wechat"
  };

  UserDao dao = UserDao();

  dao.unbindExternalUser(data).then((res) {
    loading.hide();
    if (res['status'] == '') {
      ctx.dispatch(ProfileActionCreator.unbind());
    }
  }).catchError((err) {
    loading.hide();
    tip(ctx.context,'Unbind: $err');
  });
}
