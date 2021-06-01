import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';
import 'state.dart';

Effect<WechatLoginState> buildEffect() {
  return combineEffects(<Object, Effect<WechatLoginState>>{
    WechatLoginAction.onAlreadyHaveAccount: _onAlreadyHaveAccount,
    WechatLoginAction.onCreateAccount: _onCreateAccount,
  });
}

void _onAlreadyHaveAccount(Action action, Context<WechatLoginState> ctx) async {
  Navigator.pushNamed(ctx.context, 'wechat_bind_page');
}

void _onCreateAccount(Action action, Context<WechatLoginState> ctx) async {
  Navigator.pushNamed(ctx.context, 'wechat_bind_new_acc_page');
}
