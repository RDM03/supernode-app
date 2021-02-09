import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/login_page/datahighway_create_page/page_1.dart';
import 'package:supernodeapp/page/login_page/datahighway_import_page/page_1.dart';
import 'package:supernodeapp/page/login_page/supernode_login_page/view.dart';
import 'package:supernodeapp/route.dart';

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
            SizedBox(height: 60),
            Center(child: Image.asset(AppImages.datadash)),
            SizedBox(height: 35),
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
  Widget circleButton(String text, IconData icon, {VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            height: 50,
            width: 50,
            child: Icon(
              icon,
              size: 40,
            ),
          ),
          SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget imageWithText(String text, ImageProvider image,
      {double fontSize = 16}) {
    return Stack(
      children: [
        Positioned.fill(child: Image(image: image)),
        AspectRatio(
          aspectRatio: 2.82,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Animation<double> mxcAnimation() => AlwaysStoppedAnimation(
        max(min(mxcWidth / minCardWidth - 1, 1), 0),
      );

  Widget mxcCardContent(BuildContext context) {
    final animation = mxcAnimation();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
              Tween<double>(begin: 80, end: 20).evaluate(animation)),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(
              Tween<double>(begin: 30, end: 20).evaluate(animation)),
          bottomLeft: Radius.circular(20),
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xFF02FFD8),
            Color(0xFF1C1478),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: TweenSequence([
              TweenSequenceItem(
                tween: Tween<double>(begin: 300, end: 250),
                weight: 40.0,
              ),
              TweenSequenceItem(
                tween: Tween<double>(begin: 250, end: 60),
                weight: 60.0,
              ),
            ]).evaluate(animation),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                final animationValue = animation.value;
                if (animationValue <= 0.01) {
                  openMxc();
                }
                if (animationValue >= 0.99) {
                  closeCards();
                }
              },
              child: LayoutBuilder(builder: (ctx, cnstr) {
                final Size biggest = cnstr.biggest;
                return Stack(
                  children: [
                    PositionedTransition(
                      rect: RelativeRectTween(
                        begin: RelativeRect.fromSize(
                          Rect.fromLTWH(biggest.width - 130 - 16, 16, 130, 130),
                          biggest,
                        ),
                        end: RelativeRect.fromSize(
                          Rect.fromLTWH(16, 15, 40, 40),
                          biggest,
                        ),
                      ).animate(animation),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Image.asset(AppImages.mxc),
                      ),
                    ),
                    PositionedTransition(
                      rect: RelativeRectTween(
                        begin: RelativeRect.fromSize(
                          Rect.fromLTWH(biggest.width - 130 - 16, 162, 130, 30),
                          biggest,
                        ),
                        end: RelativeRect.fromSize(
                          Rect.fromLTWH((biggest.width - 130) / 2, 26, 130, 30),
                          biggest,
                        ),
                      ).animate(animation),
                      child: Text(
                        'SUPERNODE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 36,
                      top: 190,
                      child: FadeTransition(
                        opacity: TweenSequence<double>([
                          TweenSequenceItem(
                            tween: Tween<double>(begin: 1, end: 0),
                            weight: 30.0,
                          ),
                          TweenSequenceItem(
                            tween: ConstantTween(0),
                            weight: 70.0,
                          ),
                        ]).animate(animation),
                        child: Text(
                          'Learn More',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    PositionedTransition(
                      rect: RelativeRectTween(
                        begin: RelativeRect.fromSize(
                          Rect.fromLTWH(biggest.width - 18 - 16, 191, 18, 18),
                          biggest,
                        ),
                        end: RelativeRect.fromSize(
                          Rect.fromLTWH(biggest.width - 40 - 16, 16, 40, 40),
                          biggest,
                        ),
                      ).animate(animation),
                      child: RotationTransition(
                        turns: Tween<double>(begin: 0, end: 0.5)
                            .animate(animation),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: Tween<double>(begin: 16, end: 40)
                              .evaluate(animation),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Expanded(
            child: FadeTransition(
              opacity: TweenSequence<double>([
                TweenSequenceItem(
                  tween: ConstantTween(0),
                  weight: 50.0,
                ),
                TweenSequenceItem(
                  tween: Tween<double>(begin: 0, end: 1),
                  weight: 50.0,
                ),
              ]).animate(animation),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Expanded(
                      flex: 3,
                      child: imageWithText(
                        'What is a Supernode?',
                        AssetImage(AppImages.mxcSite1),
                        fontSize: Tween<double>(begin: 3, end: 16)
                            .evaluate(animation),
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      flex: 3,
                      child: imageWithText(
                        'How to Become a Supernode',
                        AssetImage(AppImages.mxcSite2),
                        fontSize: Tween<double>(begin: 3, end: 16)
                            .evaluate(animation),
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      flex: 3,
                      child: imageWithText(
                        'Supernode Staking and Profit Sharing',
                        AssetImage(AppImages.mxcSite3),
                        fontSize: Tween<double>(begin: 3, end: 16)
                            .evaluate(animation),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              circleButton(
                'Signup',
                Icons.add,
              ),
              SizedBox(width: 23),
              circleButton(
                'Login',
                Icons.arrow_forward,
                onPressed: () => Navigator.of(context)
                    .push(route((ctx) => SupernodeLoginPage())),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }

  Animation<double> dhxAnimation() => AlwaysStoppedAnimation(
        max(min(dhxWidth / minCardWidth - 1, 1), 0),
      );

  Widget dhxCardContent(BuildContext context) {
    final animation = dhxAnimation();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
              Tween<double>(begin: 80, end: 20).evaluate(animation)),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(
              Tween<double>(begin: 30, end: 20).evaluate(animation)),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xFF6B0B92),
            Color(0xFF4665EA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: TweenSequence([
              TweenSequenceItem(
                tween: Tween<double>(begin: 300, end: 250),
                weight: 40.0,
              ),
              TweenSequenceItem(
                tween: Tween<double>(begin: 250, end: 60),
                weight: 60.0,
              ),
            ]).evaluate(animation),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                final animationValue = animation.value;
                if (animationValue <= 0.01) {
                  openDhx();
                }
                if (animationValue >= 0.99) {
                  closeCards();
                }
              },
              child: LayoutBuilder(builder: (ctx, cnstr) {
                final Size biggest = cnstr.biggest;
                return Stack(
                  children: [
                    PositionedTransition(
                      rect: RelativeRectTween(
                        begin: RelativeRect.fromSize(
                          Rect.fromLTWH(16, 16, 130, 130),
                          biggest,
                        ),
                        end: RelativeRect.fromSize(
                          Rect.fromLTWH(biggest.width - 44 - 16, 15, 40, 40),
                          biggest,
                        ),
                      ).animate(animation),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Image.asset(AppImages.dhx),
                      ),
                    ),
                    PositionedTransition(
                      rect: RelativeRectTween(
                        begin: RelativeRect.fromSize(
                          Rect.fromLTWH(16, 162, 160, 30),
                          biggest,
                        ),
                        end: RelativeRect.fromSize(
                          Rect.fromLTWH((biggest.width - 142) / 2, 26, 160, 30),
                          biggest,
                        ),
                      ).animate(animation),
                      child: Text(
                        'DATAHIGHWAY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 36,
                      top: 190,
                      child: FadeTransition(
                        opacity: TweenSequence<double>([
                          TweenSequenceItem(
                            tween: Tween<double>(begin: 1, end: 0),
                            weight: 30.0,
                          ),
                          TweenSequenceItem(
                            tween: ConstantTween(0),
                            weight: 70.0,
                          ),
                        ]).animate(animation),
                        child: Text(
                          'Learn More',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    PositionedTransition(
                      rect: RelativeRectTween(
                        begin: RelativeRect.fromSize(
                          Rect.fromLTWH(16, 191, 18, 18),
                          biggest,
                        ),
                        end: RelativeRect.fromSize(
                          Rect.fromLTWH(16, 16, 40, 40),
                          biggest,
                        ),
                      ).animate(animation),
                      child: RotationTransition(
                        turns: Tween<double>(begin: 0, end: 0.5)
                            .animate(animation),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: Tween<double>(begin: 16, end: 40)
                              .evaluate(animation),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Expanded(
            child: FadeTransition(
              opacity: TweenSequence<double>([
                TweenSequenceItem(
                  tween: ConstantTween(0),
                  weight: 50.0,
                ),
                TweenSequenceItem(
                  tween: Tween<double>(begin: 0, end: 1),
                  weight: 50.0,
                ),
              ]).animate(animation),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Expanded(
                      flex: 3,
                      child: imageWithText(
                        'Visit website :\nTHE NEXT GENERATION DATA TOKEN',
                        AssetImage(AppImages.dhxSite),
                        fontSize: Tween<double>(begin: 3, end: 16)
                            .evaluate(animation),
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      flex: 3,
                      child: imageWithText(
                        'Lead more :\nDHX Staking, Mining, and Earning Boosts',
                        AssetImage(AppImages.dhxSite),
                        fontSize: Tween<double>(begin: 3, end: 16)
                            .evaluate(animation),
                      ),
                    ),
                    SizedBox(height: 16),
                    Spacer(flex: 3),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              circleButton(
                'Import',
                Icons.arrow_back,
                onPressed: () => Navigator.of(context)
                    .push(route((ctx) => DataHighwayImportPage())),
              ),
              SizedBox(width: 23),
              circleButton(
                'Create',
                Icons.add,
                onPressed: () => Navigator.of(context)
                    .push(route((ctx) => DataHighwayCreatePage())),
              ),
            ],
          ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }

  double calcCardWidth() {
    return (widget.width - spaceBetweenCards) / 2;
  }

  static const double spaceBetweenCards = 5;

  @override
  void initState() {
    super.initState();
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
