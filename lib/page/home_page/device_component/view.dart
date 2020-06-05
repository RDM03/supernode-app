import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/configs/images.dart';

import 'state.dart';

Widget buildView(DeviceState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          FlutterI18n.translate(_ctx,'device'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: ListView(
          children: [
            Container(
              width: 282,
              height: 315,
              margin: EdgeInsets.only(top: 210),
              child: Image.asset(
                AppImages.noData,
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                FlutterI18n.translate(_ctx,'coming').toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  height: 1.33333,
                ),
              ),
            ),
          ],
        ),
      ),
    );
}
