import 'package:fish_redux/fish_redux.dart';

class ChooseApplicationState implements Cloneable<ChooseApplicationState> {
  int selectCameraIndex = 0;
  String smartWatchName;

  @override
  ChooseApplicationState clone() {
    return ChooseApplicationState()
    ..selectCameraIndex=selectCameraIndex;
  }
}

ChooseApplicationState initState(Map<String, dynamic> args) {
  return ChooseApplicationState();
}
