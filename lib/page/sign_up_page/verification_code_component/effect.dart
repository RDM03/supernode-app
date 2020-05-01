import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<VerificationCodeState> buildEffect() {
  return combineEffects(<Object, Effect<VerificationCodeState>>{
    // VerificationCodeAction.onContinue: _onContinue,
  });
}

void _onContinue(Action action, Context<VerificationCodeState> ctx) {
  
}
