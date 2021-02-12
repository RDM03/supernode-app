import 'package:flutter/material.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/route.dart';

import 'datahighway_create_page/page_1.dart';
import 'datahighway_import_page/page_1.dart';
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
                          fixed ? Icons.close : Icons.arrow_forward,
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
                      child: ImageWithText(
                        text: 'Visit website :\nTHE NEXT GENERATION DATA TOKEN',
                        image: AssetImage(AppImages.dhxSite),
                        fontSize: Tween<double>(begin: 3, end: 16)
                            .evaluate(animation),
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      flex: 3,
                      child: ImageWithText(
                        text:
                            'Lead more :\nDHX Staking, Mining, and Earning Boosts',
                        image: AssetImage(AppImages.dhxSite),
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
              CircleButton(
                text: 'Import',
                icon: Icons.arrow_back,
                onPressed: () => Navigator.of(context)
                    .push(route((ctx) => DataHighwayImportPage())),
              ),
              SizedBox(width: 23),
              CircleButton(
                text: 'Create',
                icon: Icons.add,
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
}
