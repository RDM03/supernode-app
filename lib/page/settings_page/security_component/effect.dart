import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SecurityState> buildEffect() {
  return combineEffects(<Object, Effect<SecurityState>>{
    SecurityAction.onChangePassword: _onChangePassword,
  });
}

void _onChangePassword(Action action, Context<SecurityState> ctx) {
}
