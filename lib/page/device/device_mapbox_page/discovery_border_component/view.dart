import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/action.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    DiscoveryBorderState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  return MediaQuery.removePadding(
    removeTop: true,
    context: viewService.context,
    child: ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 18),
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            FlutterI18n.translate(_ctx, 'border') +
                ": ${state.gatewaySliderValue.toInt()}km",
            style: kMiddleFontOfGrey,
          ),
        ),
        Slider(
          activeColor: dbm100,
          inactiveColor: darkBackground,
          value: state.gatewaySliderValue,
          onChanged: (value) {
            dispatch(DeviceMapBoxActionCreator.changeGatewaySliderValue(value));
          },
          //进度条上显示多少个刻度点
          max: 25,
          min: 0,
        ),
      ],
    ),
  );
}
