import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'action.dart';
import 'state.dart';

Effect<ForgotPasswordState> buildEffect() {
  return combineEffects(<Object, Effect<ForgotPasswordState>>{
    ForgotPasswordAction.onEmailContinue: _onEmailContinue,
    ForgotPasswordAction.onVerificationContinue: _onVerificationContinue,
    ForgotPasswordAction.onHasCode: _onHasCode,
  });
}

void _onEmailContinue(Action action, Context<ForgotPasswordState> ctx) async {
  var curState = ctx.state;
  if ((curState.emailFormKey.currentState as FormState).validate()) {
    final loading = await Loading.show(ctx.context);

    UserDao dao = UserDao();

    String languageCode = FlutterI18n.currentLocale(ctx.context).languageCode;
    String countryCode = FlutterI18n.currentLocale(ctx.context).countryCode;
    if (languageCode.contains('zh')) {
      languageCode = '$languageCode$countryCode';
    }
    var email = curState.emailCtl.text;
    Map data = {"language": languageCode, "username": email};
    ctx.dispatch(ForgotPasswordActionCreator.setEmail(email));
    List<String> users =
        StorageManager.sharedPreferences.getStringList(Config.USER_KEY) ?? [];
    if (!users.contains(email)) {
      users.add(email);
    }
    StorageManager.sharedPreferences.setStringList(Config.USER_KEY, users);
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
      if (err is DaoException && err.code == 13) {
        final scaffold = Scaffold.of(ctx.state.emailFormKey.currentContext);
        scaffold.showSnackBar(SnackBar(
          content: Text(
            FlutterI18n.translate(ctx.context, 'one_reset_email_month'),
            style: Theme.of(ctx.context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: errorColor,
        ));
      }
      // tip(ctx.context, 'UserDao register: $err');
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
    final loading = await Loading.show(ctx.context);

    List<String> codes =
        curState.codeListCtls.map((code) => code.text).toList();

    UserDao dao = UserDao();
    Map data = {
      "otp": codes.join(),
      "newPassword": confirmNewPwd,
      "username": ctx.state.email,
    };

    try {
      var res = await dao.passwordResetConfirm(data);
      loading.hide();
      mLog('passwordConfirm', res);

      tip(ctx.context, FlutterI18n.translate(ctx.context, 'update_success'),
          success: true);
      Navigator.popUntil(ctx.context, ModalRoute.withName("login_page"));
    } catch (e) {
      loading.hide();
      // tip(ctx.context, 'UserDao registerConfirm: $e');
    }
  } else {
    tip(ctx.context,
        FlutterI18n.translate(ctx.context, 'invalid verification code'));
  }
}
