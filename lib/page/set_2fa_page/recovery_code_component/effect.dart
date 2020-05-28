import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<RecoveryCodeState> buildEffect() {
  return combineEffects(<Object, Effect<RecoveryCodeState>>{
    // VerificationCodeAction.onContinue: _onContinue,
  });
}

void _onContinue(Action action, Context<RecoveryCodeState> ctx) {
  
}
