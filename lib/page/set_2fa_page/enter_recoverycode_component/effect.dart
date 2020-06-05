import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<EnterRecoveryCodeState> buildEffect() {
  return combineEffects(<Object, Effect<EnterRecoveryCodeState>>{
    // VerificationCodeAction.onContinue: _onContinue,
  });
}

void _onContinue(Action action, Context<EnterRecoveryCodeState> ctx) {

}
