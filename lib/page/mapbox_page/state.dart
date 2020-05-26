import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';

class mapboxState implements Cloneable<mapboxState> {
  List<Marker> gatewaysLocations;

  MapController mapCtl = MapController();

  @override
  mapboxState clone() {
    return mapboxState()
      ..gatewaysLocations = gatewaysLocations
      ..mapCtl = mapCtl;
  }
}

mapboxState initState(Map<String, dynamic> args) {
  return mapboxState()..gatewaysLocations = args['markers'] ?? [];
}
