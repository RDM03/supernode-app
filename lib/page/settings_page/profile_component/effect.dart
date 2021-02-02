import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';

import 'action.dart';
import 'state.dart';

Effect<ProfileState> buildEffect() {
  return combineEffects(<Object, Effect<ProfileState>>{
    ProfileAction.onUpdate: _onUpdate,
    ProfileAction.onUnbind: _onUnbind,
    ProfileAction.onShopifyEmail: _onShopifyEmail,
    ProfileAction.onShopifyEmailVerification: _onShopifyEmailVerification,
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

    dao.update({"user": data}).then((res) async {
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
      await ctx.context.read<SupernodeUserCubit>().refreshUser();
      loading.hide();
      Navigator.of(ctx.context).pop();
    }).catchError((err) {
      loading.hide();
      tip(ctx.context, 'UserDao update: $err');
    });
  }
}

void _onUnbind(Action action, Context<ProfileState> ctx) async {
  String service = action.payload;
  ctx.dispatch(ProfileActionCreator.showConfirmation(false));
  final loading = Loading.show(ctx.context);

  Map data = {
    "organizationId": ctx.context.read<SupernodeCubit>().state.orgId,
    "service": service
  };

  UserDao dao = _buildUserDao(ctx);

  dao.unbindExternalUser(data).then((res) {
    loading.hide();
    if (service == ExternalUser.weChatService)
      ctx.context.read<SupernodeUserCubit>().removeWeChatUser();
    else if (service == ExternalUser.shopifyService)
      ctx.context.read<SupernodeUserCubit>().removeShopifyUser();
    ctx.dispatch(ProfileActionCreator.unbind(service));
  }).catchError((err) {
    loading.hide();
    tip(ctx.context, 'Unbind: $err');
  });
}

void _onShopifyEmail(Action action, Context<ProfileState> ctx) async {
  String email = action.payload;

  if (email.isNotEmpty) {
    final loading = Loading.show(ctx.context);

    String languageCode = FlutterI18n.currentLocale(ctx.context).languageCode;
    String countryCode = FlutterI18n.currentLocale(ctx.context).countryCode;
    if (languageCode.contains('zh')) {
      languageCode = '$languageCode$countryCode';
    }

    Map apiData = {
      "email": email,
      "language": languageCode,
      "organizationId": ctx.context.read<SupernodeCubit>().state.orgId
    };

    UserDao dao = _buildUserDao(ctx);

    dao.verifyExternalEmail(apiData).then((res) {
      loading.hide();
      ctx.dispatch(ProfileActionCreator.bindShopifyStep(2));
    }).catchError((err) {
      loading.hide();
      tip(ctx.context, 'verifyExternalEmail: $err');
    });
  }
}

void _onShopifyEmailVerification(
    Action action, Context<ProfileState> ctx) async {
  String verificationCode = action.payload;

  if (verificationCode.isNotEmpty) {
    final loading = Loading.show(ctx.context);

    Map apiData = {
      "organizationId": ctx.context.read<SupernodeCubit>().state.orgId,
      "token": verificationCode
    };

    UserDao dao = _buildUserDao(ctx);

    dao.confirmExternalEmail(apiData).then((res) {
      loading.hide();
      ctx.dispatch(ProfileActionCreator.bindShopifyStep(3));
    }).catchError((err) {
      loading.hide();
      tip(ctx.context, 'confirmExternalEmail: $err');
    });
  }
}
