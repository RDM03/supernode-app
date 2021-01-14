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
import 'package:supernodeapp/common/utils/log.dart';

import 'action.dart';
import 'state.dart';

Effect<SignUpState> buildEffect() {
  return combineEffects(<Object, Effect<SignUpState>>{
    SignUpAction.onEmailContinue: _onEmailContinue,
    SignUpAction.onVerificationContinue: _onVerificationContinue,
    SignUpAction.onRegistrationContinue: _onRegistrationContinue,
  });
}

UserDao buildUserDao(Context<SignUpState> ctx) {
  return ctx.context.read<SupernodeRepository>().user;
}

void _onEmailContinue(Action action, Context<SignUpState> ctx) async {
  var curState = ctx.state;
  if ((curState.emailFormKey.currentState as FormState).validate()) {
    final loading = await Loading.show(ctx.context);

    UserDao dao = buildUserDao(ctx);

    String languageCode = FlutterI18n.currentLocale(ctx.context).languageCode;
    String countryCode = FlutterI18n.currentLocale(ctx.context).countryCode;
    if (languageCode.contains('zh')) {
      languageCode = '$languageCode$countryCode';
    }

    Map data = {"email": curState.emailCtl.text, "language": languageCode};
    dao.register(data).then((res) {
      loading.hide();
      mLog('register', res);

      Navigator.push(
        ctx.context,
        MaterialPageRoute(
          maintainState: false,
          fullscreenDialog: false,
          builder: (context) {
            return ctx.buildComponent('verification');
          },
        ),
      );
    }).catchError((err, c) {
      loading.hide();
      tip(ctx.context, err);
    });
  }
}

void _onVerificationContinue(Action action, Context<SignUpState> ctx) async {
  var curState = ctx.state;

  if ((curState.codesFormKey.currentState as FormState).validate()) {
    final loading = await Loading.show(ctx.context);

    List<String> codes =
        curState.codeListCtls.map((code) => code.text).toList();

    UserDao dao = buildUserDao(ctx);
    Map data = {"token": codes.join()};

    dao.registerConfirm(data).then((res) {
      loading.hide();
      mLog('registerConfirm', res);
      ctx.state.jwtToken = res.jwt;
      ctx.state.username = res.username;

      ctx.dispatch(
          SignUpActionCreator.registrationContinue(res.username, res.id));

      Navigator.push(
        ctx.context,
        MaterialPageRoute(
            maintainState: false,
            fullscreenDialog: false,
            builder: (context) {
              return ctx.buildComponent('registration');
            }),
      );
    }).catchError((err) {
      loading.hide();
      // tip(ctx.context,'UserDao registerConfirm: $err');
    });
  } else {
    tip(ctx.context,
        FlutterI18n.translate(ctx.context, 'invalid verification code'));
  }
}

void _onRegistrationContinue(Action action, Context<SignUpState> ctx) async {
  var curState = ctx.state;

  if ((curState.registerFormKey.currentState as FormState).validate()) {
    if (!curState.isCheckTerms) {
      return;
    }
    final loading = await Loading.show(ctx.context);
    UserDao dao = buildUserDao(ctx);
    Map data = {
      "organizationName": curState.orgCtl.text,
      "organizationDisplayName": curState.displayCtl.text,
      "userId": curState.userId,
      "password": curState.pwdCtl.text
    };

    dao.registerFinish(data, ctx.state.jwtToken).then((res) {
      loading.hide();
      mLog('UserDao registerFinish', res);

      ctx.context.read<SupernodeCubit>().setOrganizationId('todo');
      ctx.context.read<SupernodeCubit>().setSupernodeUser(SupernodeUser(
            username: curState.username,
            password: curState.pwdCtl.text,
            token: curState.jwtToken,
            userId: int.tryParse(curState.userId),
            node: ctx.context.read<SupernodeCubit>().state.selectedNode,
          ));

      Navigator.of(ctx.context).pushNamed('add_gateway_page',
          arguments: {'fromPage': 'registration'});
    }).catchError((err) {
      loading.hide();
      // tip(ctx.context,'UserDao registerFinish: $err');
    });
  }
}
