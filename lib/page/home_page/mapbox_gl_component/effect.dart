import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<MapboxGlState> buildEffect() {
  return combineEffects(<Object, Effect<MapboxGlState>>{
    MapboxGlAction.action: _onAction,
  });
}

void _onAction(Action action, Context<MapboxGlState> ctx) {
}
