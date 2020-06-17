import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/map_box.dart';

class MapBoxState implements Cloneable<MapBoxState> {
  List<MapMarker> gatewaysLocations;
  MapboxMapController mapCtl;

  @override
  MapBoxState clone() {
    return MapBoxState()
      ..gatewaysLocations = gatewaysLocations
      ..mapCtl = mapCtl;
  }
}

MapBoxState initState(Map<String, dynamic> args) {
  return MapBoxState()..gatewaysLocations = args['markers'] ?? [];
}
