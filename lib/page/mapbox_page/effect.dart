import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';
import 'package:supernodeapp/common/components/location_utils.dart';
import 'action.dart';
import 'state.dart';

Effect<MapBoxState> buildEffect() {
  return combineEffects(<Object, Effect<MapBoxState>>{
    Lifecycle.initState: _initState,
    MapBoxAction.action: _onAction,
  });
}

void _initState(Action action, Context<MapBoxState> ctx) {
  if (LocationUtils.locationData != null) {
    final loc = LatLng(LocationUtils.locationData.latitude, LocationUtils.locationData.longitude);
    ctx.dispatch(MapBoxActionCreator.onLocation(loc));
  } else {
    _getLocation(ctx);
  }
}

Future<void> _getLocation(Context<MapBoxState> ctx) async {
  await LocationUtils.getLocation();
  if (LocationUtils.locationData != null) {
    final loc = LatLng(LocationUtils.locationData.latitude, LocationUtils.locationData.longitude);
    ctx.dispatch(MapBoxActionCreator.onLocation(loc));
  }
}

void _onAction(Action action, Context<MapBoxState> ctx) {}
