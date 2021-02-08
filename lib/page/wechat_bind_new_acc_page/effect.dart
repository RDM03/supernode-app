import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/auth.dart';
import 'package:supernodeapp/page/home_page/home_page.dart';
import 'package:supernodeapp/route.dart';

import 'action.dart';
import 'state.dart';

Effect<WechatBindNewAccState> buildEffect() {
  return combineEffects(<Object, Effect<WechatBindNewAccState>>{
    WechatBindNewAccAction.onBindNewAcc: _onBindNewAcc,
  });
}

UserDao _buildUserDao(Context<WechatBindNewAccState> ctx) {
  return ctx.context.read<SupernodeRepository>().main.user;
}

void _onBindNewAcc(Action action, Context<WechatBindNewAccState> ctx) async {
  var curState = ctx.state;

  if ((curState.formKey.currentState as FormState).validate()) {
    final loading = Loading.show(ctx.context);
    try {
      UserDao dao = _buildUserDao(ctx);
      final email = curState.emailCtl.text.trim();
      final orgName = curState.orgCtl.text.trim();
      final orgDisplayName = curState.displayCtl.text.trim();

      await _handleBindNewAccRequest(dao, email, orgName, orgDisplayName, ctx);

      Navigator.pushAndRemoveUntil(
          ctx.context, route((ctx) => HomePage()), (_) => false);
    } catch (err) {
      loading.hide();
      final res = await checkMaintenance(
          ctx.context.read<SupernodeCubit>().state.selectedNode);
      if (!res) return;
      tip(ctx.context,
          err?.message ?? FlutterI18n.translate(ctx.context, 'error_tip'));
    } finally {
      loading.hide();
    }
  }
}

Future<void> _handleBindNewAccRequest(UserDao dao, String email, String orgName,
    String orgDisplayName, Context<WechatBindNewAccState> ctx) async {
  Map data = {
    "email": email,
    "organizationDisplayName": orgDisplayName,
    "organizationName": orgName
  };

  var registerExtUserResult = await dao.registerExternalUser(data);

  final jwt = registerExtUserResult['jwt'];

  ctx.context.read<SupernodeCubit>().setSupernodeSession(SupernodeSession(
        username: email,
        password: '',
        token: jwt,
        userId: parseJwt(jwt).userId,
        node: ctx.context.read<SupernodeCubit>().state.selectedNode,
      ));

  final profile = await dao.profile();
  ctx.context.read<SupernodeCubit>().setOrganizationId(
        profile.organizations.first.organizationID,
      );
}
