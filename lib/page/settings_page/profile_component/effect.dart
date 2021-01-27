import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/auth.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/config.dart';

import 'action.dart';
import 'state.dart';

Effect<ProfileState> buildEffect() {
  return combineEffects(<Object, Effect<ProfileState>>{
    ProfileAction.onUpdate: _onUpdate,
    ProfileAction.onUnbind: _onUnbind,
  });
}

UserDao _buildUserDao(Context<ProfileState> ctx) {
  return ctx.context.read<SupernodeRepository>().user;
}

void _onUpdate(Action action, Context<ProfileState> ctx) async {
  var curState = ctx.state;

  if ((curState.formKey.currentState as FormState).validate()) {
    final loading = Loading.show(ctx.context);
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

    UserDao dao = _buildUserDao(ctx);

    dao.update({"user": data}).then((res) {
      mLog('update', res);

      String jwt = res['jwt'];
      if (jwt != null && jwt.isNotEmpty) {
        ctx.context.read<SupernodeCubit>().setSupernodeSession(
              ctx.context.read<SupernodeCubit>().state.session.copyWith(
                    token: jwt,
                    username: username,
                  ),
            );
        ctx.dispatch(ProfileActionCreator.jwtUpdate(data));
      }
      loading.hide();
      Navigator.of(ctx.context).pop();
    }).catchError((err) {
      loading.hide();
      tip(ctx.context, 'UserDao update: $err');
    });
  }
}

void _onUnbind(Action action, Context<ProfileState> ctx) async {
  ctx.dispatch(ProfileActionCreator.showConfirmation(false));
  final loading = Loading.show(ctx.context);

  Map data = {
    "organizationId": ctx.context.read<SupernodeCubit>().state.orgId,
    "service": "wechat"
  };

  UserDao dao = _buildUserDao(ctx);

  dao.unbindExternalUser(data).then((res) {
    loading.hide();
    ctx.dispatch(ProfileActionCreator.unbind());
  }).catchError((err) {
    loading.hide();
    tip(ctx.context, 'Unbind: $err');
  });
}
