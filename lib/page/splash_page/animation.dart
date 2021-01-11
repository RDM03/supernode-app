/*
*  splash_logo_animation.dart
*  Supernode app
*
*  Created by shargeel.
*  Copyright © 2018 MXC. All rights reserved.
    */

import 'package:flutter/widgets.dart';
import 'package:supernova_flutter_ui_toolkit/keyframes.dart';

Animation<double> _createScaleProperty(
        AnimationController animationController) =>
    Interpolation<double>(keyframes: [
      Keyframe<double>(fraction: 0, value: 1),
      Keyframe<double>(fraction: 0.00001, value: 0.1),
      Keyframe<double>(fraction: 0.6, value: 0.475),
      Keyframe<double>(fraction: 1, value: 1),
    ]).animate(CurvedAnimation(
      curve: Interval(0, 1, curve: Cubic(0, 0, 1, 1)),
      parent: animationController,
    ));

Animation<double> _createTranslationYProperty(
        AnimationController animationController) =>
    Interpolation<double>(keyframes: [
      Keyframe<double>(fraction: 0, value: 0),
      Keyframe<double>(fraction: 0.00001, value: 1000),
      Keyframe<double>(fraction: 0.6, value: -60),
      Keyframe<double>(fraction: 1, value: 0),
    ]).animate(CurvedAnimation(
      curve: Interval(0, 1, curve: Cubic(0, 0, 1, 1)),
      parent: animationController,
    ));

Animation<double> _createOpacityProperty(
        AnimationController animationController) =>
    Interpolation<double>(keyframes: [
      Keyframe<double>(fraction: 0, value: 1),
      Keyframe<double>(fraction: 0.00001, value: 0),
      Keyframe<double>(fraction: 0.6, value: 1),
      Keyframe<double>(fraction: 1, value: 1),
    ]).animate(CurvedAnimation(
      curve: Interval(0, 1, curve: Cubic(0, 0, 1, 1)),
      parent: animationController,
    ));

class SplashLogoAnimation extends StatelessWidget {
  SplashLogoAnimation(
      {Key key, this.child, @required AnimationController animationController})
      : assert(animationController != null),
        this.scale = _createScaleProperty(animationController),
        this.translationY = _createTranslationYProperty(animationController),
        this.opacity = _createOpacityProperty(animationController),
        super(key: key);

  final Animation<double> scale;
  final Animation<double> translationY;
  final Animation<double> opacity;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        this.scale,
        this.translationY,
        this.opacity,
      ]),
      child: this.child,
      builder: (context, widget) {
        return Opacity(
          opacity: this.opacity.value,
          child: Transform.translate(
            offset: Offset(0, this.translationY.value),
            child: Transform.scale(
              scale: this.scale.value,
              alignment: Alignment.center,
              child: widget,
            ),
          ),
        );
      },
    );
  }
}
