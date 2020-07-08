import 'package:fish_redux/fish_redux.dart';

enum ChooseApplicationAction { changeCamera, setSmartWatch }

class ChooseApplicationActionCreator {
  static Action onChangeCamera(int selectIndex) {
    return Action(ChooseApplicationAction.changeCamera, payload: selectIndex);
  }

  static Action setSmartWatch(String smartWatch) {
    return Action(ChooseApplicationAction.setSmartWatch, payload: smartWatch);
  }
}
