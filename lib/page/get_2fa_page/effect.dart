import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:supernodeapp/page/get_2fa_page/action.dart';

import 'state.dart';

Effect<Get2FAState> buildEffect() {
  return combineEffects(<Object, Effect<Get2FAState>>{
    Get2FAAction.onClose: _onClose,
    Get2FAAction.onSubmit: _onSubmit,
  });
}

void _onClose(Action action, Context<Get2FAState> ctx) {
  Navigator.of(ctx.context).pop();
}

void _onSubmit(Action action, Context<Get2FAState> ctx) {
  Navigator.of(ctx.context).pop(ctx.state.otpCode);
}
