import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/page/login_page/login_generic.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_state.dart';
import '../../route.dart';
import 'about_component/about_page.dart';
import 'account_component/account_page.dart';
import 'address_book/address_book_picker.dart';
import 'app_settings/app_settings_page.dart';
import 'bloc/settings/cubit.dart';
import 'export_data/export_data_page.dart';
import 'links_component/links_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (a, b) => a.language != b.language,
      builder: (ctx, s) => Scaffold(
          appBar: AppBars.backArrowAppBar(
              title: FlutterI18n.translate(context, 'settings'),
              onPress: () => {Navigator.of(context).pop()}),
          body: WillPopScope(
              onWillPop: () async {
                Navigator.pop(context);
                return false;
              },
              child: pageFrame(
                context: context,
                padding: EdgeInsets.all(0.0),
                children: <Widget>[
                  BlocBuilder<AppCubit, AppState>(
                    buildWhen: (a, b) => a.isDemo != b.isDemo,
                    builder: (ctx, s) => listItem(
                        FlutterI18n.translate(context, 'manage_account'),
                        key: Key('manageAccountItem'),
                        trailing:
                            s.isDemo ? Icon(Icons.do_not_disturb_alt) : null,
                        onTap: s.isDemo
                            ? null
                            : () => Navigator.push(
                                context, route((context) => AccountPage()))),
                  ),
                  Divider(),
                  BlocBuilder<AppCubit, AppState>(
                    buildWhen: (a, b) => a.isDemo != b.isDemo,
                    builder: (ctx, s) => listItem(
                        FlutterI18n.translate(context, 'app_settings'),
                        key: Key('appSettingsItem'),
                        trailing:
                            s.isDemo ? Icon(Icons.do_not_disturb_alt) : null,
                        onTap: s.isDemo
                            ? null
                            : () => Navigator.push(context,
                                route((context) => AppSettingsPage()))),
                  ),
                  Divider(),
                  listItem(
                    FlutterI18n.translate(context, 'address_book'),
                    onTap: () => Navigator.of(context)
                        .push(route((_) => AddressBookPicker())),
                    key: ValueKey('addressBookItem'),
                  ),
                  Divider(),
                  listItem(FlutterI18n.translate(context, 'about'), onTap: () {
                    context.read<SettingsCubit>().initAboutPage();
                    Navigator.push(context, route((context) => AboutPage()));
                  }),
                  Divider(),
                  listItem(FlutterI18n.translate(context, 'connect_with_us'),
                      onTap: () => Navigator.push(
                          context, route((context) => LinksPage()))),
                  Divider(),
                  listItem(FlutterI18n.translate(context, 'rate_app'),
                      onTap: () async {
                    try {
                      await launch(
                          "itms-apps://itunes.apple.com/app/id1509218470");
                    } on PlatformException catch (e) {
                      launch(
                          "https://play.google.com/store/apps/details?id=com.mxc.smartcity");
                    }
                  }),
                  Divider(),
                  BlocBuilder<AppCubit, AppState>(
                      buildWhen: (a, b) => a.isDemo != b.isDemo,
                      builder: (ctx, s) => listItem(
                          FlutterI18n.translate(context, 'export_mining_data'),
                          key: Key('export'),
                          onTap: () => s.isDemo
                              ? 'no action'
                              : Navigator.push(context,
                                  route((context) => ExportDataPage())))),
                  Divider(),
                  listItem(FlutterI18n.translate(context, 'logout'),
                      key: Key('logout'), trailing: Text(''), onTap: () {
                    context.read<SupernodeCubit>().logout();
                    navigatorKey.currentState.pushAndRemoveUntil(
                        route((_) => LoginPage()), (route) => false);
                  }),
                ],
              ))),
    );
  }
}
