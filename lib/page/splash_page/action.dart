import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;

enum SplashAction {
  initAnimate,
  goNextPage,
  animatePlayStateChange,
  initDataStateChange
}

class SplashActionCreator {
  static Action initAnimate(TickerProvider ticker) {
    return Action(SplashAction.initAnimate, payload: ticker);
  }

  static Action goNextPage() {
    return const Action(SplashAction.goNextPage);
  }

  static Action animatePlayStateChange(bool state) {
    return Action(SplashAction.animatePlayStateChange, payload: state);
  }

  static Action initDataStateChange(bool state) {
    return Action(SplashAction.initDataStateChange, payload: state);
  }
}
