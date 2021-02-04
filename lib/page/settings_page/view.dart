import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SettingsState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return Scaffold(
      appBar: AppBars.backArrowAppBar(
          title: FlutterI18n.translate(_ctx, 'settings'),
          onPress: () => {
                Navigator.of(viewService.context).pop({
                  'username': state.username,
                  'email': state.email,
                  'reloadProfile': state.reloadProfile
                })
              }),
      body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(_ctx, {
              'username': state.username,
              'email': state.email,
              'reloadProfile': state.reloadProfile
            });
            return false;
          },
          child: PageBody(children: [
            PanelFrame(
                child: Column(
              children: <Widget>[
                listItem(
                    FlutterI18n.translate(
                        _ctx, SettingsOption.manage_account.label),
                    trailing:
                        state.isDemo ? Icon(Icons.do_not_disturb_alt) : null,
                    onTap: state.isDemo
                        ? null
                        : () => dispatch(SettingsActionCreator.onSettings(
                            SettingsOption.manage_account))),
                Divider(),
                listItem(
                    FlutterI18n.translate(
                        _ctx, SettingsOption.app_settings.label),
                    trailing:
                        state.isDemo ? Icon(Icons.do_not_disturb_alt) : null,
                    onTap: state.isDemo
                        ? null
                        : () => dispatch(SettingsActionCreator.onSettings(
                            SettingsOption.app_settings))),
                Divider(),
                listItem(
                  FlutterI18n.translate(
                      _ctx, SettingsOption.address_book.label),
                  onTap: () => dispatch(SettingsActionCreator.onSettings(
                      SettingsOption.address_book)),
                  key: ValueKey('addressBookItem'),
                ),
                Divider(),
                listItem(
                    FlutterI18n.translate(_ctx, SettingsOption.about.label),
                    onTap: () => dispatch(SettingsActionCreator.onSettings(
                        SettingsOption.about))),
                Divider(),
                listItem(FlutterI18n.translate(_ctx, 'connect_with_us'),
                    onTap: () => dispatch(SettingsActionCreator.onSettings(
                        SettingsOption.links))),
                Divider(),
                listItem(
                    FlutterI18n.translate(_ctx, SettingsOption.rate_app.label),
                    onTap: () => dispatch(SettingsActionCreator.onSettings(
                        SettingsOption.rate_app))),
                Divider(),
                listItem(
                    FlutterI18n.translate(
                        _ctx, SettingsOption.export_mining_data.label),
                    onTap: () => dispatch(SettingsActionCreator.onSettings(
                        SettingsOption.export_mining_data))),
                Divider(),
                listItem(
                    FlutterI18n.translate(_ctx, SettingsOption.logout.label),
                    key: Key('logout'),
                    trailing: Text(''),
                    onTap: () => dispatch(SettingsActionCreator.onSettings(
                        SettingsOption.logout))),
              ],
            )),
            SizedBox(height: 15)
          ])));
}
