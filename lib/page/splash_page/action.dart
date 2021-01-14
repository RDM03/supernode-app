import 'package:fish_redux/fish_redux.dart';

enum SplashAction { goNextPage }

class SplashActionCreator {
  static Action goNextPage() {
    return const Action(SplashAction.goNextPage);
  }
}
