import 'package:fish_redux/fish_redux.dart';

class FootprintsState implements Cloneable<FootprintsState> {
 int footPrintsType = 0;
  @override
  FootprintsState clone() {
    return FootprintsState()
    ..footPrintsType = footPrintsType;
  }
}

FootprintsState initState(Map<String, dynamic> args) {
  return FootprintsState();
}
