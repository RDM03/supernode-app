import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';

//TODO replace with your own action
enum MapBoxAction {
  action,
  location,
}

class MapBoxActionCreator {
  static Action onAction() {
    return const Action(MapBoxAction.action);
  }

  static Action onLocation(LatLng location){
    return Action(MapBoxAction.location, payload: location);
  }
}
