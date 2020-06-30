import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

class SplashState implements Cloneable<SplashState> {
  AnimationController logoController;
  bool isAnimatePlayed = false;
  bool isDataLoaded = false;

  @override
  SplashState clone() {
    return SplashState()
      ..logoController = logoController
      ..isAnimatePlayed = isAnimatePlayed
      ..isDataLoaded = isDataLoaded;
  }
}

SplashState initState(Map<String, dynamic> args) {
  return SplashState();
}
