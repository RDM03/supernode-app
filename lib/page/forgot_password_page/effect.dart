import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/shared/clients/client.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/page/login_page/login_generic.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'action.dart';
import 'state.dart';

Effect<ForgotPasswordState> buildEffect() {
  return combineEffects(<Object, Effect<ForgotPasswordState>>{
    ForgotPasswordAction.onEmailContinue: _onEmailContinue,
    ForgotPasswordAction.onVerificationContinue: _onVerificationContinue,
    ForgotPasswordAction.onHasCode: _onHasCode,
  });
}

UserDao _buildUserDao(Context<ForgotPasswordState> ctx) {
  return ctx.context.read<SupernodeRepository>().user;
}

void _onEmailContinue(Action action, Context<ForgotPasswordState> ctx) async {
  var curState = ctx.state;
  if ((curState.emailFormKey.currentState as FormState).validate()) {
    final loading = Loading.show(ctx.context);

    UserDao dao = _buildUserDao(ctx);

    String languageCode = FlutterI18n.currentLocale(ctx.context).languageCode;
    String countryCode = FlutterI18n.currentLocale(ctx.context).countryCode;
    if (languageCode.contains('zh')) {
      languageCode = '$languageCode$countryCode';
    }
    var email = curState.emailCtl.text.toLowerCase();
    Map data = {"language": languageCode, "username": email};
    ctx.dispatch(ForgotPasswordActionCreator.setEmail(email));
    try {
      var res = await dao.passwordReset(data);
      loading.hide();
      L.dTag('register', "$res");
      Navigator.push(
        ctx.context,
        MaterialPageRoute(
          maintainState: false,
          fullscreenDialog: false,
          builder: (context) {
            return ctx.buildComponent('pwd_reset');
          },
        ),
      );
    } catch (err) {
      loading.hide();
      if (err is HttpException && err.code == 13) {
        final scaffold = Scaffold.of(ctx.state.emailFormKey.currentContext);
        scaffold.showSnackBar(SnackBar(
          content: Text(
            FlutterI18n.translate(ctx.context, 'one_reset_email_month'),
            style: Theme.of(ctx.context).textTheme.bodyText1.copyWith(
                  color: ColorsTheme.of(ctx.context).textPrimaryAndIcons,
                ),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: ColorsTheme.of(ctx.context).textError,
        ));
      }
      // tip('UserDao register: $err');
    }
  }
}

void _onHasCode(Action action, Context<ForgotPasswordState> ctx) async {
  Navigator.push(
    ctx.context,
    MaterialPageRoute(
      maintainState: false,
      fullscreenDialog: false,
      builder: (context) {
        return ctx.buildComponent('pwd_reset');
      },
    ),
  );
}

void _onVerificationContinue(
    Action action, Context<ForgotPasswordState> ctx) async {
  var curState = ctx.state;

  if ((curState.codesFormKey.currentState as FormState).validate()) {
    String confirmNewPwd = curState.confirmNewPwdCtl.text;
    final loading = Loading.show(ctx.context);

    List<String> codes =
        curState.codeListCtls.map((code) => code.text).toList();

    UserDao dao = _buildUserDao(ctx);
    Map data = {
      "otp": codes.join(),
      "newPassword": confirmNewPwd,
      "username": ctx.state.email,
    };

    try {
      var res = await dao.passwordResetConfirm(data);
      loading.hide();
      mLog('passwordConfirm', res);

      tip(FlutterI18n.translate(ctx.context, 'update_success'), success: true);
      Navigator.of(ctx.context)
          .pushAndRemoveUntil(routeWidget(LoginPage()), (_) => false);
    } catch (e) {
      loading.hide();
      // tip('UserDao registerConfirm: $e');
    }
  } else {
    tip(FlutterI18n.translate(ctx.context, 'invalid verification code'));
  }
}
