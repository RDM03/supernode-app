import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<WechatLoginState> buildEffect() {
  return combineEffects(<Object, Effect<WechatLoginState>>{
    WechatLoginAction.onAlreadyHaveAccount: _onAlreadyHaveAccount,
    WechatLoginAction.onCreateAccount: _onCreateAccount,
  });
}

void _onAlreadyHaveAccount(Action action, Context<WechatLoginState> ctx) async {
}

void _onCreateAccount(Action action, Context<WechatLoginState> ctx) async {
}

