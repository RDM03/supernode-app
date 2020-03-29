import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/ui/login/login_route.dart';

import '../../router_service.dart';
import 'splash_logo_animation.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController logoAnimationController;

  @override
  void initState() {
    super.initState();
    this.logoAnimationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    this.startAnimationOne();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    this.logoAnimationController.dispose();
  }

  void startAnimationOne() => this.logoAnimationController.forward();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          children: [
            Container(
              width: 245,
              height: 116,
              margin: EdgeInsets.only(top: 282),
              child: SplashLogoAnimation(
                animationController: this.logoAnimationController,
                child: Image.asset("assets/images/mxc-logo-social-2.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 3000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    RouterService.instance.navigateTo(LogInRoute.buildPath());
  }
}
