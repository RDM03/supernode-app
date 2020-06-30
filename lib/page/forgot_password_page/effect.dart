import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/configs/config.dart';
import 'action.dart';
import 'state.dart';

Effect<ForgotPasswordState> buildEffect() {
  return combineEffects(<Object, Effect<ForgotPasswordState>>{
    ForgotPasswordAction.onEmailContinue: _onEmailContinue,
    ForgotPasswordAction.onVerificationContinue: _onVerificationContinue,
  });
}

void _onEmailContinue(Action action, Context<ForgotPasswordState> ctx) async {
  var curState = ctx.state;
  if ((curState.emailFormKey.currentState as FormState).validate()) {
    showLoading(ctx.context);

    UserDao dao = UserDao();

    String languageCode = FlutterI18n.currentLocale(ctx.context).languageCode;
    String countryCode = FlutterI18n.currentLocale(ctx.context).countryCode;
    if (languageCode.contains('zh')) {
      languageCode = '$languageCode$countryCode';
    }
    var email = curState.emailCtl.text;
    Map data = {"language": languageCode, "username": email};
    ctx.dispatch(ForgotPasswordActionCreator.setEmail(email));
    List<String> users = StorageManager.sharedPreferences.getStringList(Config.USER_KEY) ?? [];
    if (!users.contains(email)) {
      users.add(email);
    }
    StorageManager.sharedPreferences.setStringList(Config.USER_KEY, users);
    try {
      var res = await dao.passwordReset(data);
      hideLoading(ctx.context);
      L.dTag('register', "$res");
      Navigator.push(
        ctx.context,
        MaterialPageRoute(
            maintainState: false,
            fullscreenDialog: false,
            builder: (context) {
              return ctx.buildComponent('pwd_reset');
            }),
      );
    } catch (err) {
      hideLoading(ctx.context);
      tip(ctx.context, 'UserDao register: $err');
    }
  }
}

void _onVerificationContinue(Action action, Context<ForgotPasswordState> ctx) async {
  var curState = ctx.state;

  if ((curState.codesFormKey.currentState as FormState).validate()) {
    String confirmNewPwd = curState.confirmNewPwdCtl.text;

    showLoading(ctx.context);

    List<String> codes = curState.codeListCtls.map((code) => code.text).toList();

    UserDao dao = UserDao();
    Map data = {
      "otp": codes.join(),
      "newPassword": confirmNewPwd,
      "username": ctx.state.email,
    };

    try {
      var res = await dao.passwordResetConfirm(data);
      hideLoading(ctx.context);
      mLog('passwordConfirm', res);

      tip(ctx.context, FlutterI18n.translate(ctx.context, 'update_success'), success: true);
      Navigator.popUntil(ctx.context, ModalRoute.withName("login_page"));
    } catch (e) {
      hideLoading(ctx.context);
      tip(ctx.context, 'UserDao registerConfirm: $e');
    }
  } else {
    tip(ctx.context, FlutterI18n.translate(ctx.context, 'invalid verification code'));
  }
}
