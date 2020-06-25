import 'package:fish_redux/fish_redux.dart';
import 'state.dart';

Effect<MapBoxState> buildEffect() {
  return combineEffects(<Object, Effect<MapBoxState>>{
    Lifecycle.initState: _initState,
  });
}

void _initState(Action action, Context<MapBoxState> ctx) {}
