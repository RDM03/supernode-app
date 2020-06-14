import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/map_box.dart';

class mapboxState implements Cloneable<mapboxState> {
  List<MapMarker> gatewaysLocations;
  LatLng myLocation;
  MapboxMapController mapCtl;

  @override
  mapboxState clone() {
    return mapboxState()
      ..gatewaysLocations = gatewaysLocations
      ..myLocation = myLocation
      ..mapCtl = mapCtl;
  }
}

mapboxState initState(Map<String, dynamic> args) {
  return mapboxState()..gatewaysLocations = args['markers'] ?? [];
}
