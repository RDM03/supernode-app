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
import 'action.dart';
import 'state.dart';

Effect<WechatBindState> buildEffect() {
  return combineEffects(<Object, Effect<WechatBindState>>{
    WechatBindAction.onBind: _onBind,
  });
}

UserDao _buildUserDao(Context<WechatBindState> ctx) {
  return ctx.context.read<SupernodeRepository>().main.user;
}

void _onBind(Action action, Context<WechatBindState> ctx) async {
  var curState = ctx.state;

  if ((curState.formKey.currentState as FormState).validate()) {
    final loading = Loading.show(ctx.context);
    try {
      UserDao dao = _buildUserDao(ctx);
      final email = curState.usernameCtl.text.trim();
      final password = curState.passwordCtl.text.trim();

      await _handleBindRequest(dao, email, password, ctx);

      Navigator.pushNamedAndRemoveUntil(ctx.context, 'home_page', (_) => false);
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

Future<void> _handleBindRequest(UserDao dao, String email, String password,
    Context<WechatBindState> ctx) async {
  Map data = {'email': email, 'password': password};

  final bindExtUserResult = await dao.bindExternalUser(data);
  final jwt = bindExtUserResult['jwt'];

  ctx.context.read<SupernodeCubit>().setSupernodeSession(SupernodeSession(
        username: email,
        password: password,
        token: jwt,
        userId: parseJwt(jwt).userId,
        node: ctx.context.read<SupernodeCubit>().state.selectedNode,
      ));

  final profile = await dao.profile();
  ctx.context.read<SupernodeCubit>().setOrganizationId(
        profile.organizations.first.organizationID,
      );
}
