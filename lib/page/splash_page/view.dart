import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/configs/images.dart';

import 'action.dart';
import 'state.dart';
import 'animation.dart';

Widget buildView(SplashState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        children: [
          Container(
            width: 245,
            height: 116,
            margin: const EdgeInsets.only(top: 282),
            child: SplashLogoAnimation(
              animationController: state.logoAnimationController,
              child: Image.asset(AppImages.splashLogo),
            ),
          ),
        ],
      ),
    ),
  );
}
