import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

//TODO replace with your own action
enum MapBoxAction {
  addLocation,
  addMapController,
}

class MapBoxActionCreator {
  static Action addLocation(LatLng location) {
    return Action(MapBoxAction.addLocation, payload: location);
  }

  static Action addMapController(MapboxMapController ctl) {
    return Action(MapBoxAction.addMapController, payload: ctl);
  }
}
