import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/wallet_component/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:url_launcher/url_launcher.dart';

class MiningTutorial extends StatefulWidget {
  final BuildContext _ctx;
  List<Widget> _pages;

  MiningTutorial (this._ctx) {
    this._pages = [_page1(_ctx), _page2(_ctx), _page3(_ctx), _page4(_ctx)];
  }

  @override
  State<StatefulWidget> createState() => _MiningTutorialState();

  Widget _bubble(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.all(s(8)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: tutorialBubble),
      child: RichText(textAlign: TextAlign.center, text: TextSpan(children: [
        TextSpan(text: FlutterI18n.translate(ctx, "tutorial_bubble"), style: kBigFontOfBlack),
        TextSpan(text: FlutterI18n.translate(ctx, "tutorial_bubble2"), style: kBigBoldFontOfBlack)])));
  }

  Widget _pageBase(List<Widget> wgts) {
    return
      Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 20.0),
        child: ListView(children: wgts)
      );
  }

  Widget _page1 (BuildContext ctx) {
    return _pageBase([
      Text(FlutterI18n.translate(ctx, "tutorial_pg1_title"), style: kPrimaryBigFontOfBlack),
      SizedBox(height: s(10)),
      Text(FlutterI18n.translate(ctx, "tutorial_pg1_text"), style: kBigFontOfBlack),
      SizedBox(height: s(40)),
      Stack(alignment: AlignmentDirectional.center, children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Image.asset(AppImages.rocket)),
        Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Image.asset(AppImages.mcxBubble),
              ),
              SizedBox(height: s(230)),
              CircleButton(
                  onTap: () => launch('https://www.matchx.io/product/m2-pro-lpwan-crypto-miner/'),
                  icon: Icon(Icons.shopping_basket, color: colorToken[Token.DHX]),
                  label: "Shop Miner"),
            ],
          ),
          SizedBox(width: s(80)),
          Padding(
            padding: const EdgeInsets.only(right: 35),
            child: Image.asset(AppImages.minerBubble)),
        ])
      ]),
      SizedBox(height: s(15)),
      _bubble(ctx),
      SizedBox(height: 25)
    ]);
  }

  Widget _page2 (BuildContext ctx) {
    return  _pageBase([
      Text(FlutterI18n.translate(ctx, "tutorial_pg2_title"), style: kPrimaryBigFontOfBlack),
      SizedBox(height: s(10)),
      Text(FlutterI18n.translate(ctx, "tutorial_pg2_text"), style: kBigFontOfBlack),
      SizedBox(height: s(30)),
      Row(children: [
        Spacer(),
        Column(children: [
          Text('1', style: kSuperBigBoldFont),
          SizedBox(height: s(10)),
          Container(
              decoration: BoxDecoration(
                  color: colorToken[Token.DHX],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(FlutterI18n.translate(ctx, 'mxc_locked'), style: kSecondaryButtonOfWhite),
              )
          )
        ]),
        Spacer(),
        Text('=', style: kSuperBigBoldFont),
        Spacer(),
        Column(children: [
          Text('1', style: kSuperBigBoldFont),
          SizedBox(height: s(10)),
          Container(
              decoration: BoxDecoration(
                  color: colorToken[Token.DHX],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Stack(alignment: AlignmentDirectional.center, children: [
                    Text(FlutterI18n.translate(ctx, 'mxc_locked'), style:TextStyle(color: colorToken[Token.DHX], fontFamily: "Roboto", fontSize: 14)),// invisible - sets width for Container
                    Text(FlutterI18n.translate(ctx, 'mpower'), style: kSecondaryButtonOfWhite)
                  ])
              )
          )
        ]),
        Spacer(),
      ]),
      SizedBox(height: s(10)),
      Text(FlutterI18n.translate(ctx, "tutorial_pg2_desc1"), style: kMiddleFontOfBlack),
      SizedBox(height: s(30)),
      Row(children: [
        Spacer(),
        Column(children: [
          Text('1', style: kSuperBigBoldFont),
          SizedBox(height: s(10)),
          Container(
              decoration: BoxDecoration(
                  color: colorToken[Token.DHX],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Stack(alignment: AlignmentDirectional.center, children: [
                    Text(FlutterI18n.translate(ctx, 'm2pro_miner'), style: kSecondaryButtonOfWhite),
                  ])
              )
          )
        ]),
        Spacer(),
        Text('=', style: kSuperBigBoldFont),
        Spacer(),
        Column(children: [
          RichText(text: TextSpan(children: [TextSpan(text: '100% ', style: kSuperBigBoldFont), TextSpan(text: 'Boost', style: kBigFontOfBlack)])),
          SizedBox(height: s(10)),
          Container(
              decoration: BoxDecoration(
                  color: colorToken[Token.DHX],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Stack(alignment: AlignmentDirectional.center, children: [
                    Text(FlutterI18n.translate(ctx, 'm2pro_miner'), style:TextStyle(color: colorToken[Token.DHX], fontFamily: "Roboto", fontSize: 14)),// invisible - sets width for Container
                    Text(FlutterI18n.translate(ctx, 'mpower'), style: kSecondaryButtonOfWhite)
                  ])
              )
          )
        ]),
        Spacer(),
      ]),
      SizedBox(height: s(10)),
      Text(FlutterI18n.translate(ctx, "tutorial_pg2_desc2"), style: kMiddleFontOfBlack),
      SizedBox(height: s(30)),
      Column(children: [
        Icon(Icons.calendar_today),
        SizedBox(height: s(10)),
        Container(
            decoration: BoxDecoration(
                color: colorToken[Token.DHX],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(FlutterI18n.translate(ctx, 'mining_term'), style: kSecondaryButtonOfWhite)
            )
        )
      ]),
      SizedBox(height: s(10)),
      Text(FlutterI18n.translate(ctx, "tutorial_pg2_desc3"), style: kMiddleFontOfBlack),
      SizedBox(height: s(15)),
      _bubble(ctx),
      SizedBox(height: 25)
    ]);
  }

  Widget _page3 (BuildContext ctx) {
    return _pageBase([
      Text(FlutterI18n.translate(ctx, "tutorial_pg3_title"), style: kPrimaryBigFontOfBlack),
      SizedBox(height: s(10)),
      Text(FlutterI18n.translate(ctx, "tutorial_pg3_text"), style: kBigFontOfBlack),
      SizedBox(height: s(30)),
      Row(children: [
        Container(
            decoration: BoxDecoration(
                color: colorToken[Token.DHX],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Text('40% ' + FlutterI18n.translate(ctx, 'boost'), style: kSecondaryButtonOfWhite),
            )
        ),
        Spacer(),
        Container(
            decoration: BoxDecoration(
                color: colorToken[Token.DHX],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text('0% ' + FlutterI18n.translate(ctx, 'boost'), style: kSecondaryButtonOfWhite),
            )
        )
      ]),
      Image.asset(AppImages.minerBoostGraph, height: 200),
      Row(children: [
        Container(
            decoration: BoxDecoration(
                color: colorToken[Token.DHX],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Text('20% ' + FlutterI18n.translate(ctx, 'boost'), style: kSecondaryButtonOfWhite),
            )
        ),
        Spacer(),
        Container(
            decoration: BoxDecoration(
                color: colorToken[Token.DHX],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Text('10% ' + FlutterI18n.translate(ctx, 'boost'), style: kSecondaryButtonOfWhite),
            )
        )
      ]),
      SizedBox(height: s(30)),
      _bubble(ctx),
      SizedBox(height: 25)
    ]);
  }

  Widget _page4 (BuildContext ctx) {
    return _pageBase([
      Text(FlutterI18n.translate(ctx, "tutorial_pg4_title"), style: kPrimaryBigFontOfBlack),
      SizedBox(height: s(10)),
      Text(FlutterI18n.translate(ctx, "tutorial_pg4_text"), style: kBigFontOfBlack),
      SizedBox(height: 40),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [BoxShadow(color: darkBackground, offset: Offset(0, 2), blurRadius: 7, spreadRadius: 0.0)]
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              decoration: BoxDecoration(color: colorToken[Token.DHX], borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
              child: Image.asset(AppImages.iconCouncil, color:Colors.white)),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('council@mxc.org', style: kMiddleFontOfBlueLink),
                SizedBox(height: 5),
                Text('MatchX (Germany)'),
                SizedBox(height: 5),
                Text(FlutterI18n.translate(ctx, "latest_mpower") + ' : 5000000'),
              ]),
            )
          ],
        )
      ),
      submitButton(
        FlutterI18n.translate(ctx, "tutorial_pg4_button"),
        top: 50,
        onPressed: () => Navigator.pop(ctx)),
      SizedBox(height: s(15)),
      _bubble(ctx),
      SizedBox(height: 25)
    ]);
  }
}

class _MiningTutorialState extends State<MiningTutorial> {
  int currentPageValue = 0;

  @override
  Widget build(BuildContext context) {
    return Stack (
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        PageView(
          onPageChanged: (int page) {
            currentPageValue = page;
            setState(() {});
          },
          children: widget._pages,
        ),
        Container(
          width: double.infinity,
          height: 50,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [transparentWhite, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.center),
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget> [
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < widget._pages.length; i++)
                      if (i == currentPageValue) ...[circleBar(true)] else
                        circleBar(false),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? colorToken[Token.DHX] : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}