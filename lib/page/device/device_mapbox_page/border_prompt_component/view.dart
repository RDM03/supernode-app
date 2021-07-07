import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/action.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    BorderPromptState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  var screenSize = MediaQuery.of(_ctx);
  return Container(
    color: Color.fromRGBO(0, 0, 0, 0.74),
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 41,
              height: 128,
              child: Image.asset('assets/images/device/arrow_gatway.png',
                  fit: BoxFit.contain),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                FlutterI18n.translate(_ctx, 'set_border_step1'),
                style: kBigFontOfWhite,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 70,
              height: 131,
              child: Image.asset(
                'assets/images/device/point_pin.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                FlutterI18n.translate(_ctx, 'set_border_step2'),
                style: kBigFontOfWhite,
              ),
            )
          ],
        ),
        Positioned(
          top: 50 + (screenSize?.padding?.top ?? 0),
          left: 22 + (screenSize?.padding?.left ?? 0),
          child: InkWell(
            onTap: () {
              dispatch(DeviceMapBoxActionCreator.setBorderPromptVisible(false));
            },
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: unknownColor3,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 6,
                        color: Colors.white)
                  ]),
              child: Icon(
                Icons.close,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
