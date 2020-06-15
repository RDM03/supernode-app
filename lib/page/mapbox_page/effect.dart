import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/location_utils.dart';
import 'action.dart';
import 'state.dart';

Effect<MapBoxState> buildEffect() {
  return combineEffects(<Object, Effect<MapBoxState>>{
    Lifecycle.initState: _initState,
  });
}

void _initState(Action action, Context<MapBoxState> ctx) {
  if (LocationUtils.locationData != null) {
    final loc = LatLng(LocationUtils.locationData.latitude, LocationUtils.locationData.longitude);
    ctx.dispatch(MapBoxActionCreator.addLocation(loc));
  } else {
    _getLocation(ctx);
  }
}

Future<void> _getLocation(Context<MapBoxState> ctx) async {
  await LocationUtils.getLocation();
  if (LocationUtils.locationData != null) {
    final loc = LatLng(LocationUtils.locationData.latitude, LocationUtils.locationData.longitude);
    ctx.dispatch(MapBoxActionCreator.addLocation(loc));
  }
}

