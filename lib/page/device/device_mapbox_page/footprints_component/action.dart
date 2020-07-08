import 'package:fish_redux/fish_redux.dart';

enum FootprintsAction { changeFootPrintsType }

class FootprintsActionCreator {
  static Action onChangeFootPrintsType(int type) {
    return Action(FootprintsAction.changeFootPrintsType, payload: type);
  }
}
