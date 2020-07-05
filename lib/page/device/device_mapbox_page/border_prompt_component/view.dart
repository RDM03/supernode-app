import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/action.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(BorderPromptState state, Dispatch dispatch,
    ViewService viewService) {
  var _ctx = viewService.context;
  return Container(
    color: Color.fromRGBO(0, 0, 0, 0.74),
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                FlutterI18n.translate(_ctx, 'set_border_step1'),
                style: kBigFontOfWhite,
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
          top: 42,
          right: 17,
          child: InkWell(
            onTap: () {
              dispatch(DeviceMapBoxActionCreator.setBorderPromptVisible(false));
            },
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF343434),
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
