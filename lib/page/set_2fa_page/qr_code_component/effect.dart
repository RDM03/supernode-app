import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<QRCodeState> buildEffect() {
  return combineEffects(<Object, Effect<QRCodeState>>{
    // VerificationCodeAction.onContinue: _onContinue,
  });
}

void _onContinue(Action action, Context<QRCodeState> ctx) {

}
