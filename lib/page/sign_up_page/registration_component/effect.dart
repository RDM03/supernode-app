import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<RegistrationState> buildEffect() {
  return combineEffects(<Object, Effect<RegistrationState>>{
    // RegistrationAction.action: _onAction,
  });
}

void _onAction(Action action, Context<RegistrationState> ctx) {
}
