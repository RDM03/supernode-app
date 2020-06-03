import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/components/my_location.dart';
import 'action.dart';
import 'state.dart';

Effect<mapboxState> buildEffect() {
  return combineEffects(<Object, Effect<mapboxState>>{
    Lifecycle.initState : _initState,
    mapboxAction.action: _onAction,
  });
}

void _initState(Action action, Context<mapboxState> ctx) {
  if (MyLocation.locationData!= null) {
    ctx.state.myLocationData = MyLocation.locationData;
  }else{
    _getLocation(ctx);
  }
}

Future<void> _getLocation(Context<mapboxState> ctx) async {
  await MyLocation.getLocation();
  ctx.state.myLocationData = MyLocation.locationData;
}

void _onAction(Action action, Context<mapboxState> ctx) {
}
