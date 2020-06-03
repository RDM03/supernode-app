import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';
import 'package:supernodeapp/common/components/location_utils.dart';

import 'action.dart';
import 'state.dart';

Effect<mapboxState> buildEffect() {
  return combineEffects(<Object, Effect<mapboxState>>{
    Lifecycle.initState: _initState,
    mapboxAction.action: _onAction,
  });
}

void _initState(Action action, Context<mapboxState> ctx) {
  if (LocationUtils.loc != null) {
    ctx.state.myLocation =
        LatLng(LocationUtils.loc.latLng.latitude, LocationUtils.loc.latLng.longitude);
  } else {
    _getLocation(ctx);
  }
}

Future<void> _getLocation(Context<mapboxState> ctx) async {
  if (await LocationUtils.requestPermission()) {
    final _loc = await LocationUtils.getMyLocation();
    ctx.state.myLocation = LatLng(_loc.latLng.latitude, _loc.latLng.longitude);
  }
}

void _onAction(Action action, Context<mapboxState> ctx) {}
