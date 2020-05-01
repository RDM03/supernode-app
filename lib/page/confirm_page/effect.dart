import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ConfirmState> buildEffect() {
  return combineEffects(<Object, Effect<ConfirmState>>{
    ConfirmAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ConfirmState> ctx) {
}
