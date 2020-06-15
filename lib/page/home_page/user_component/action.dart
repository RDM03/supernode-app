import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

import 'state.dart';

enum UserAction { addLocation, addMapController }

class UserActionCreator {
  static Action addLocation(LatLng location) {
    return Action(UserAction.addLocation, payload: location);
  }

  static Action addMapController(MapboxMapController ctl) {
    return Action(UserAction.addMapController, payload: ctl);
  }
}
