import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

class SplashState implements Cloneable<SplashState> {

  AnimationController logoAnimationController;
 
  @override
  SplashState clone() {
    return SplashState();
  }
}

SplashState initState(Map<String, dynamic> args) {
  return SplashState();
}
