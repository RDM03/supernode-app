import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/page/settings_page/action.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    AccountState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(
      context: _ctx,
      padding: EdgeInsets.all(0.0),
      children: <Widget>[
        ListTile(
          title: Center(
              child: Text(FlutterI18n.translate(_ctx, SettingsOption.manage_account.label),
                  style: kBigBoldFontOfBlack)),
          trailing: GestureDetector(
              child: Icon(Icons.close, color: Colors.black),
              onTap: () => Navigator.of(_ctx).pop()),
        ),
        Divider(),
        listItem(FlutterI18n.translate(_ctx, 'super_node'),
            onTap: () => dispatch(
                SettingsActionCreator.onSettings(SettingsOption.profile)),
            leading: Image.asset(Token.mxc.imagePath, height: s(50))),
        Divider(),
        listItem(FlutterI18n.translate(_ctx, 'datahighway_parachain'),
            onTap: () => dispatch(
                SettingsActionCreator.onSettings(SettingsOption.profileDhx)),
            leading: Image.asset(Token.supernodeDhx.imagePath, height: s(50))),
      ]);
}
