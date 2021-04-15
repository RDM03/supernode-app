import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/home_page.dart';
import 'package:supernodeapp/page/login_page/supernode_login_page/cubit.dart';
import 'package:supernodeapp/page/login_page/supernode_login_page/state.dart';
import 'package:supernodeapp/page/login_page/supernode_login_page/view.dart';
import 'package:supernodeapp/page/sign_up_page/supernode_signup_page.dart';
import 'package:supernodeapp/route.dart';

import '../../app_cubit.dart';
import 'shared.dart';

class SupernodeLoginCard extends StatefulWidget {
  final Animation<double> animation;
  final VoidCallback onTap;
  final bool fixed;

  const SupernodeLoginCard({
    Key key,
    this.animation,
    this.onTap,
    this.fixed = false,
  }) : super(key: key);

  @override
  _SupernodeLoginCardContentState createState() =>
      _SupernodeLoginCardContentState(
          onTap: onTap,
          fixed: fixed);
}

class _SupernodeLoginCardContentState
    extends State<SupernodeLoginCard> {
  final VoidCallback onTap;
  final bool fixed;
  LoginCubit loginCubit;

  _SupernodeLoginCardContentState({
    this.onTap,
    this.fixed = false,
  });

  @override
  void initState() {
    loginCubit = LoginCubit(
      appCubit: context.read<AppCubit>(),
      supernodeCubit: context.read<SupernodeCubit>(),
      dao: context.read<SupernodeRepository>(),
    )..initState();
    super.initState();
  }

  @override
  void dispose() {
    loginCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      cubit: loginCubit,
      listenWhen: (a, b) => a.loginResult != b.loginResult,
      listener: (ctx, state) async {
        if (state.loginResult == LoginResult.home)
          Navigator.of(context).push(route((ctx) => HomePage()));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
                Tween<double>(begin: 80, end: 20).evaluate(widget.animation)),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(
                Tween<double>(begin: 30, end: 20).evaluate(widget.animation)),
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
              ]).evaluate(widget.animation),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
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
                        ).animate(widget.animation),
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
                        ).animate(widget.animation),
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
                          ]).animate(widget.animation),
                          child: Text(
                            FlutterI18n.translate(context, 'learn_more'),
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
                        ).animate(widget.animation),
                        child: RotationTransition(
                          turns: Tween<double>(begin: 0, end: 0.5)
                              .animate(widget.animation),
                          child: Icon(
                            fixed ? Icons.close : Icons.arrow_forward,
                            color: Colors.white,
                            size: Tween<double>(begin: 16, end: 40)
                                .evaluate(widget.animation),
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
                ]).animate(widget.animation),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Expanded(
                        flex: 3,
                        child: ImageWithText(
                          text: FlutterI18n.translate(context, 'what_is_supernode'),
                          image: AssetImage(AppImages.mxcSite1),
                          fontSize: Tween<double>(begin: 3, end: 16)
                              .evaluate(widget.animation),
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        flex: 3,
                        child: ImageWithText(
                          text: FlutterI18n.translate(context, 'how_to_become_supernode'),
                          image: AssetImage(AppImages.mxcSite2),
                          fontSize: Tween<double>(begin: 3, end: 16)
                              .evaluate(widget.animation),
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        flex: 3,
                        child: ImageWithText(
                          text: FlutterI18n.translate(context, 'supernode_staking_profit_share'),
                          image: AssetImage(AppImages.mxcSite3),
                          fontSize: Tween<double>(begin: 3, end: 16)
                              .evaluate(widget.animation),
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
                CircleButton(
                  text: FlutterI18n.translate(context, 'signup'),
                  icon: Icons.add,
                  onPressed: () => Navigator.of(context).push(route((ctx) => BlocProvider<LoginCubit>.value(
                      value: loginCubit,
                      child: SupernodeSignupPage()))),
                ),
                SizedBox(width: 23),
                CircleButton(
                  text: FlutterI18n.translate(context, 'login'),
                  icon: Icons.arrow_forward,
                  onPressed: () => Navigator.of(context)
                      .push(route((ctx) => BlocProvider<LoginCubit>.value(
                      value: loginCubit,
                      child: SupernodeLoginPage()))),
                ),
                SizedBox(width: 20),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: whiteBorderButton(
                  FlutterI18n.translate(context, 'demo_login'),
                  onPressed: () => loginCubit.demoLogin()),
            ),
          ],
        ),
      ),
    );
  }
}
