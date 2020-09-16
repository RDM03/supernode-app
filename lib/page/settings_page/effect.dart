import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info/package_info.dart';
import 'package:supernodeapp/common/utils/auth.dart';
import 'package:supernodeapp/page/feedback_page/feedback.dart';

import 'action.dart';
import 'state.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future onSelectNotification(String payload) async {
  // print(payload);
}

Future onDidReceiveLocalNotification(
    int id, String title, String body, String payload) async {
  // print(title);
}

Effect<SettingsState> buildEffect() {
  return combineEffects(<Object, Effect<SettingsState>>{
    Lifecycle.initState: _initState,
    Lifecycle.dispose: _onDispose,
    SettingsAction.onSettings: _onSettings,
    SettingsAction.onSetScreenshot: _onSetScreenshot,
  });
}

void _initState(Action action, Context<SettingsState> ctx) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  ctx.dispatch(SettingsActionCreator.localVersion(version, buildNumber));
}

void _onSetScreenshot(Action action, Context<SettingsState> ctx) async {
  await DatadashFeedback.of(ctx.context).setShowScreenshot(action.payload);
  ctx.dispatch(SettingsActionCreator.blank());
}

void _onSettings(Action action, Context<SettingsState> ctx) async {
  String page = action.payload;

  if (page == 'logout') {
    await logOut(ctx.context);
    return;
  }

  if (page == 'notification') {
    try {
      _noticationEnable();
      ctx.state.notification = !ctx.state.notification;
    } catch (e) {
      ctx.state.notification = false;
    }

    ctx.dispatch(SettingsActionCreator.notification(ctx.state.notification));
    return;
  }

  if (page == 'address_book') {
    Navigator.of(ctx.context).pushNamed('address_book_page');
    return;
  }

  Navigator.push(
    ctx.context,
    MaterialPageRoute(
        maintainState: false,
        fullscreenDialog: true,
        builder: (context) {
          return ctx.buildComponent(page);
        }),
  );
}

void _noticationEnable() {
  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid =
      new AndroidInitializationSettings('app_icon');

  var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);

  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}

void _onDispose(Action action, Context<SettingsState> ctx) async {
  // await flutterLocalNotificationsPlugin.cancel(0);
  // await flutterLocalNotificationsPlugin.cancelAll();
}
