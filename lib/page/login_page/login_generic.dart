import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/login_page/parachain_card.dart';

import 'supernode_login_card.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class RectClipper extends CustomClipper<Rect> {
  final double width;

  RectClipper(this.width);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(size.width - 50, 0, 40, size.height);
  }

  @override
  bool shouldReclip(covariant RectClipper oldClipper) {
    return oldClipper.width != width;
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            Center(child: Image.asset(AppImages.datadash)),
            SizedBox(height: 25),
            Expanded(
              child: LayoutBuilder(
                builder: (ctx, cnstr) => LoginPageContent(
                  width: cnstr.maxWidth,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class LoginPageContent extends StatefulWidget {
  const LoginPageContent({Key key, this.width}) : super(key: key);
  final double width;

  @override
  _LoginPageContentState createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<LoginPageContent>
    with TickerProviderStateMixin {
  Animation<double> mxcAnimation() => AlwaysStoppedAnimation(
        max(min(mxcWidth / minCardWidth - 1, 1), 0),
      );

  Widget mxcCardContent(BuildContext context) {
    final animation = mxcAnimation();
    return SupernodeLoginCard(
      animation: animation,
      onTap: () {
        if (max(min(mxcWidth / minCardWidth - 1, 1), 0) == 0) {
          openMxc();
        }
        if (max(min(mxcWidth / minCardWidth - 1, 1), 0) == 1) {
          closeCards();
        }
      },
    );
  }

  Animation<double> dhxAnimation() => AlwaysStoppedAnimation(
        max(min(dhxWidth / minCardWidth - 1, 1), 0),
      );

  Widget dhxCardContent(BuildContext context) {
    final animation = dhxAnimation();
    return ParachainLoginCard(
      animation: animation,
      onTap: () {
        if (max(min(dhxWidth / minCardWidth - 1, 1), 0) == 0) {
          openDhx();
        }
        if (max(min(dhxWidth / minCardWidth - 1, 1), 0) == 1) {
          closeCards();
        }
      },
    );
  }

  double calcCardWidth() {
    return (widget.width - spaceBetweenCards) / 2;
  }

  static const double spaceBetweenCards = 5;

  @override
  void initState() {
    super.initState();

    // DemoMode => logout
    if (context.read<SupernodeCubit>().state.session != null &&
        context.read<SupernodeCubit>().state.session.userId == -1)
      context.read<SupernodeCubit>().logout();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    controller.addListener(() {
      if (animation?.value != null) setMxcWidth(animation.value);
    });
    initWidths();
  }

  @override
  void didUpdateWidget(covariant LoginPageContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.width != widget.width) {
      initWidths();
    }
  }

  void initWidths() {
    controller.stop();
    mxcWidth = calcCardWidth();
    dhxWidth = calcCardWidth();
    minCardWidth = calcCardWidth();
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void runAnimationMxc(Offset pixelsPerSecond) {
    final unitsPerSecondX = pixelsPerSecond.dx / mxcWidth;

    final movingToOpen = mxcWidth - mxcWidthAtStart > 0;

    if (((movingToOpen && unitsPerSecondX > -1) &&
            (mxcWidth - minCardWidth) / minCardWidth > 0.2) ||
        ((!movingToOpen && unitsPerSecondX > -2) &&
            (mxcWidth - minCardWidth) / minCardWidth > 0.8)) {
      animation = controller.drive(
        Tween(begin: mxcWidth, end: widget.width),
      );
    } else {
      animation = controller.drive(
        Tween(begin: mxcWidth, end: minCardWidth),
      );
    }

    final spring = SpringDescription.withDampingRatio(
      mass: 30,
      stiffness: 1,
      ratio: 0.2,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitsPerSecondX);
    controller.animateWith(simulation);
  }

  void runAnimationDhx(Offset pixelsPerSecond) {
    final unitsPerSecondX = pixelsPerSecond.dx / dhxWidth;

    final movingToOpen = dhxWidth - dhxWidthAtStart > 0;

    if (((movingToOpen && unitsPerSecondX < 1) &&
            (dhxWidth - minCardWidth) / minCardWidth > 0.2) ||
        ((!movingToOpen && unitsPerSecondX < 2) &&
            (dhxWidth - minCardWidth) / minCardWidth > 0.8)) {
      animation = controller.drive(
        Tween(begin: mxcWidth, end: -spaceBetweenCards),
      );
    } else {
      animation = controller.drive(
        Tween(begin: mxcWidth, end: minCardWidth),
      );
    }

    final spring = SpringDescription.withDampingRatio(
      mass: 30,
      stiffness: 1,
      ratio: 0.2,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitsPerSecondX);
    controller.animateWith(simulation);
  }

  Animation<double> animation;

  double mxcWidthAtStart;
  double dhxWidthAtStart;
  double mxcWidth;
  double dhxWidth;
  double minCardWidth;

  AnimationController controller;

  void setMxcWidth(double width) {
    setState(() {
      mxcWidth = width;
      dhxWidth = widget.width - spaceBetweenCards - mxcWidth;
    });
  }

  void setDhxWidth(double width) {
    setState(() {
      mxcWidth = widget.width - spaceBetweenCards - dhxWidth;
      dhxWidth = width;
    });
  }

  void closeCards() {
    animation = controller.drive(
      Tween(begin: mxcWidth, end: minCardWidth),
    );
    controller.reset();
    controller.animateTo(1, curve: Curves.easeInOut);
  }

  void openDhx() {
    animation = controller.drive(
      Tween(begin: mxcWidth, end: -spaceBetweenCards),
    );
    controller.reset();
    controller.animateTo(1, curve: Curves.easeInOut);
  }

  void openMxc() {
    animation = controller.drive(
      Tween(begin: mxcWidth, end: widget.width),
    );
    controller.reset();
    controller.animateTo(1, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: -widget.width + mxcWidth,
          width: widget.width,
          bottom: 0,
          top: 0,
          child: GestureDetector(
            onHorizontalDragDown: (details) {
              mxcWidthAtStart = mxcWidth;
            },
            onHorizontalDragEnd: (details) {
              runAnimationMxc(details.velocity.pixelsPerSecond);
            },
            onHorizontalDragUpdate: (d) {
              controller.stop();
              final newMxcWidth = mxcWidth + d.delta.dx;
              if (newMxcWidth < minCardWidth)
                setState(() {
                  mxcWidth = minCardWidth;
                  dhxWidth = minCardWidth;
                });
              else
                setMxcWidth(newMxcWidth);
            },
            child: mxcCardContent(context),
          ),
        ),
        Positioned(
          right: -widget.width + dhxWidth,
          width: widget.width,
          bottom: 0,
          top: 0,
          child: GestureDetector(
            onHorizontalDragDown: (details) {
              dhxWidthAtStart = dhxWidth;
            },
            onHorizontalDragEnd: (details) {
              runAnimationDhx(details.velocity.pixelsPerSecond);
            },
            onHorizontalDragUpdate: (d) {
              controller.stop();
              final newDhxWidth = dhxWidth - d.delta.dx;
              if (newDhxWidth < minCardWidth)
                setState(() {
                  mxcWidth = minCardWidth;
                  dhxWidth = minCardWidth;
                });
              else
                setDhxWidth(newDhxWidth);
            },
            child: dhxCardContent(context),
          ),
        ),
      ],
    );
  }
}
