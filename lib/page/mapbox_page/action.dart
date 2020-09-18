import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/components/map_box.dart';

enum MapBoxAction {
  addMapController,
}

class MapBoxActionCreator {
  static Action addMapController(MapViewController ctl) {
    return Action(MapBoxAction.addMapController, payload: ctl);
  }
}
