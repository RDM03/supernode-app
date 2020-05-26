import 'package:fish_redux/fish_redux.dart';
//import 'package:supernodeapp/page/home_page/state.dart';
import 'action.dart';
import 'state.dart';

Effect<mapboxState> buildEffect() {
  return combineEffects(<Object, Effect<mapboxState>>{
    mapboxAction.action: _onAction,
  });
}

void _onAction(Action action, Context<mapboxState> ctx) {
}
