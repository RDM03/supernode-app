import 'package:fish_redux/fish_redux.dart';

class MapboxGlState implements Cloneable<MapboxGlState> {
  List geojsonList = [];

  @override
  MapboxGlState clone() {
    return MapboxGlState()..geojsonList = geojsonList;
  }
}

MapboxGlState initState(Map<String, dynamic> args) {
  return MapboxGlState();
}
