import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<EnterNonOTPSecurityCodeState> buildEffect() {
  return combineEffects(<Object, Effect<EnterNonOTPSecurityCodeState>>{
    // VerificationCodeAction.onContinue: _onContinue,
  });
}

void _onContinue(Action action, Context<EnterNonOTPSecurityCodeState> ctx) {

}
