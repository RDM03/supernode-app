import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart' hide Action;

import 'action.dart';
import 'state.dart';

Reducer<SplashState> buildReducer() {
  return asReducer(
    <Object, Reducer<SplashState>>{
      SplashAction.initAnimate: _initAnimate,
      SplashAction.animatePlayStateChange: _animatePlayStateChange,
      SplashAction.initDataStateChange: _initDataStateChange,
    },
  );
}

SplashState _initAnimate(SplashState state, Action action) {
  final SplashState newState = state.clone();
  newState.logoController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: action.payload as TickerProvider);
  return newState;
}

SplashState _animatePlayStateChange(SplashState state, Action action) {
  final SplashState newState = state.clone();
  newState.isAnimatePlayed = action.payload;
  return newState;
}

SplashState _initDataStateChange(SplashState state, Action action) {
  final SplashState newState = state.clone();
  newState.isDataLoaded = action.payload;
  return newState;
}
