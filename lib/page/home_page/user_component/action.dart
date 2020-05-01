import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';

import 'state.dart';

enum UserAction { addLocation }

class UserActionCreator {
  static Action addLocation(LatLng location) {
    return Action(UserAction.addLocation,payload: location);
  }
}
