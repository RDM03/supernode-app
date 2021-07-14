import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import 'shared.dart';

class ParachainLoginCard extends StatelessWidget {
  final Animation<double> animation;
  final VoidCallback onTap;
  final bool fixed;

  const ParachainLoginCard({
    Key key,
    this.animation,
    this.onTap,
    this.fixed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            loginDhxGradientStart,
            loginDhxGradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              onTap: onTap,
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
                          color: darkThemeColors.textPrimaryAndIcons,
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
                        style: FontTheme.of(context).veryBig().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: darkThemeColors.textPrimaryAndIcons,
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
                          FlutterI18n.translate(context, 'learn_more'),
                          style: TextStyle(
                            color: darkThemeColors.textPrimaryAndIcons,
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
                          fixed ? Icons.close : Icons.arrow_back,
                          color: darkThemeColors.textPrimaryAndIcons,
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
                      flex: 5,
                      child: GestureDetector(
                        onTap: () => launch('https://www.datahighway.com/'),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: Tween<double>(begin: 0, end: 10)
                                  .evaluate(animation)),
                          decoration: BoxDecoration(
                            color: lightThemeColors.textPrimaryAndIcons,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.home,
                                size: Tween<double>(begin: 0, end: 24)
                                    .evaluate(animation),
                                color: darkThemeColors.textPrimaryAndIcons,
                              ),
                              SizedBox(
                                height: Tween<double>(begin: 0, end: 5)
                                    .evaluate(animation),
                              ),
                              Text(
                                FlutterI18n.translate(
                                  context,
                                  'next_gen_data_token',
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Tween<double>(begin: 0, end: 16)
                                      .evaluate(animation),
                                  color: darkThemeColors.textPrimaryAndIcons,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: Tween<double>(begin: 0, end: 16)
                            .evaluate(animation)),
                    Expanded(
                      flex: 5,
                      child: GestureDetector(
                        onTap: () => launch(
                            'https://datahighway-dhx.medium.com/dhx-staking-mining-and-earning-boosts-c4f88c060014'),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: Tween<double>(begin: 0, end: 10)
                                  .evaluate(animation)),
                          decoration: BoxDecoration(
                            color: lightThemeColors.textPrimaryAndIcons,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                AppImages.medium,
                                width: Tween<double>(begin: 0, end: 24)
                                    .evaluate(animation),
                                height: Tween<double>(begin: 0, end: 24)
                                    .evaluate(animation),
                                color: darkThemeColors.textPrimaryAndIcons,
                              ),
                              SizedBox(
                                  height: Tween<double>(begin: 0, end: 5)
                                      .evaluate(animation)),
                              Text(
                                FlutterI18n.translate(
                                    context, 'dhx_staking_mining_earning'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Tween<double>(begin: 0, end: 16)
                                      .evaluate(animation),
                                  color: darkThemeColors.textPrimaryAndIcons,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              FadeTransition(
                  opacity: TweenSequence<double>([
                    TweenSequenceItem(
                      tween: ConstantTween(1),
                      weight: 20.0,
                    ),
                    TweenSequenceItem(
                      tween: Tween<double>(begin: 1, end: 0),
                      weight: 60.0,
                    ),
                    TweenSequenceItem(
                      tween: ConstantTween(0),
                      weight: 20.0,
                    ),
                  ]).animate(animation),
                  child: CircleButton(
                    text: FlutterI18n.translate(context, 'import'),
                    icon: Icons.arrow_back,
                    //onPressed: () => Navigator.of(context).push(route((ctx) => DataHighwayImportPage())),
                  )),
              SizedBox(width: 23),
              FadeTransition(
                  opacity: TweenSequence<double>([
                    TweenSequenceItem(
                      tween: ConstantTween(1),
                      weight: 20.0,
                    ),
                    TweenSequenceItem(
                      tween: Tween<double>(begin: 1, end: 0),
                      weight: 60.0,
                    ),
                    TweenSequenceItem(
                      tween: ConstantTween(0),
                      weight: 20.0,
                    ),
                  ]).animate(animation),
                  child: CircleButton(
                    text: FlutterI18n.translate(context, 'create'),
                    icon: Icons.add,
                    //onPressed: () => Navigator.of(context).push(route((ctx) => DataHighwayCreatePage())),
                  )),
              FadeTransition(
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
                child: Text(
                  FlutterI18n.translate(context, 'coming').toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: darkThemeColors.textPrimaryAndIcons,
                  ),
                ),
              )
            ],
          ),
          FadeTransition(
              opacity: TweenSequence<double>([
                TweenSequenceItem(
                  tween: ConstantTween(1),
                  weight: 20.0,
                ),
                TweenSequenceItem(
                  tween: Tween<double>(begin: 1, end: 0),
                  weight: 60.0,
                ),
                TweenSequenceItem(
                  tween: ConstantTween(0),
                  weight: 20.0,
                ),
              ]).animate(animation),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: WhiteBorderButton(
                      FlutterI18n.translate(context, 'demo_login'))))
        ],
      ),
    );
  }
}
