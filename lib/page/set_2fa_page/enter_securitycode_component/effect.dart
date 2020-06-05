import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<EnterSecurityCodeState> buildEffect() {
  return combineEffects(<Object, Effect<EnterSecurityCodeState>>{
    // VerificationCodeAction.onContinue: _onContinue,
  });
}

void _onContinue(Action action, Context<EnterSecurityCodeState> ctx) {

}
