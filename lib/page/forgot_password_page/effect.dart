import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ForgotPasswordState> buildEffect() {
  return combineEffects(<Object, Effect<ForgotPasswordState>>{
    ForgotPasswordAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ForgotPasswordState> ctx) {
}
