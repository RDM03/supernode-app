import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

class MapBoxState implements Cloneable<MapBoxState> {
  List<Marker> gatewaysLocations;
  LatLng myLocation;
  MapController mapCtl = MapController();

  @override
  MapBoxState clone() {
    return MapBoxState()
      ..gatewaysLocations = gatewaysLocations
      ..myLocation = myLocation
      ..mapCtl = mapCtl;
  }
}

MapBoxState initState(Map<String, dynamic> args) {
  return MapBoxState()..gatewaysLocations = args['markers'] ?? [];
}
