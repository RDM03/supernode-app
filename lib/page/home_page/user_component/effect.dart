import 'package:fish_redux/fish_redux.dart';

import '../action.dart';
import 'state.dart';

Effect<UserState> buildEffect() {
  return combineEffects(<Object, Effect<UserState>>{
    Lifecycle.disappear: _disappear,
  });
}

void _disappear(Action action, Context<UserState> ctx) {
  ctx.dispatch(HomeActionCreator.loading(false));
}
