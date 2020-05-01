/*
*  device_widget_animation1.dart
*  LPWAN APP
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:supernova_flutter_ui_toolkit/keyframes.dart';

Animation<double> _createRotationZProperty(AnimationController animationController) => Interpolation<double>(keyframes: [
  Keyframe<double>(fraction: 0, value: 0),
  Keyframe<double>(fraction: 0.00001, value: -200),
  Keyframe<double>(fraction: 1, value: 0),
]).animate(CurvedAnimation(
  curve: Interval(0, 1, curve: Cubic(0, 0, 1, 1)),
  parent: animationController,
));

Animation<double> _createOpacityProperty(AnimationController animationController) => Interpolation<double>(keyframes: [
  Keyframe<double>(fraction: 0, value: 1),
  Keyframe<double>(fraction: 0.00001, value: 0),
  Keyframe<double>(fraction: 1, value: 1),
]).animate(CurvedAnimation(
  curve: Interval(0, 1, curve: Cubic(0, 0, 1, 1)),
  parent: animationController,
));


class DeviceWidgetAnimation extends StatelessWidget {
  
  DeviceWidgetAnimation({
    Key key,
    this.child,
    @required AnimationController animationController
  }) : assert(animationController != null),
       this.rotationZ = _createRotationZProperty(animationController),
       this.opacity = _createOpacityProperty(animationController),
       super(key: key);
  
  final Animation<double> rotationZ;
  final Animation<double> opacity;
  final Widget child;
  
  
  @override
  Widget build(BuildContext context) {
  
    return AnimatedBuilder(
      animation: Listenable.merge([
        this.rotationZ,
        this.opacity,
      ]),
      child: this.child,
      builder: (context, widget) {
      
        return Opacity(
          opacity: this.opacity.value,
          child: Transform.rotate(
            angle: this.rotationZ.value / 180 * pi,
            alignment: Alignment.center,
            child: widget,
          ),
        );
      },
    );
  }
}