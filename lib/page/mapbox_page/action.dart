import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

enum MapBoxAction {
  addMapController,
}

class MapBoxActionCreator {
  static Action addMapController(MapboxMapController ctl) {
    return Action(MapBoxAction.addMapController, payload: ctl);
  }
}
