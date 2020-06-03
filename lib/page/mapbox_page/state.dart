import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:location/location.dart';

class mapboxState implements Cloneable<mapboxState> {
  List<Marker> gatewaysLocations;
  LocationData myLocationData;
  MapController mapCtl = MapController();

  @override
  mapboxState clone() {
    return mapboxState()
      ..gatewaysLocations = gatewaysLocations
      ..myLocationData = myLocationData
      ..mapCtl = mapCtl;
  }
}

mapboxState initState(Map<String, dynamic> args) {
  return mapboxState()..gatewaysLocations = args['markers'] ?? [];
}
