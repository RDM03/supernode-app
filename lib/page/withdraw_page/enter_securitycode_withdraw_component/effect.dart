import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<EnterSecurityCodeWithdrawState> buildEffect() {
  return combineEffects(<Object, Effect<EnterSecurityCodeWithdrawState>>{
    // VerificationCodeAction.onContinue: _onContinue,
  });
}

void _onContinue(Action action, Context<EnterSecurityCodeWithdrawState> ctx) {

}

