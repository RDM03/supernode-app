import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';
import 'package:supernodeapp/common/components/location_utils.dart';
import 'package:location/location.dart';
import 'action.dart';
import 'state.dart';

Effect<mapboxState> buildEffect() {
  return combineEffects(<Object, Effect<mapboxState>>{
    Lifecycle.initState: _initState,
    mapboxAction.action: _onAction,
  });
}

void _initState(Action action, Context<mapboxState> ctx) {
  if (LocationUtils.locationData != null) {
    ctx.state.myLocation =
        LatLng(LocationUtils.locationData.latitude, LocationUtils.locationData.longitude);
  } else {
    _getLocation(ctx);
  }
}

Future<void> _getLocation(Context<mapboxState> ctx) async {
  await LocationUtils.getLocation();
  ctx.state.myLocation =
      LatLng(LocationUtils.locationData.latitude, LocationUtils.locationData.longitude);
}

void _onAction(Action action, Context<mapboxState> ctx) {}
