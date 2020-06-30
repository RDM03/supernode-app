import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/permission_utils.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/configs/sys.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';
import 'package:supernodeapp/global_store/action.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

import 'action.dart';
import 'state.dart';

Effect<SplashState> buildEffect() {
  return combineEffects(<Object, Effect<SplashState>>{
    Lifecycle.initState: _initState,
    Lifecycle.dispose: _dispose,
    // SplashAction.action: _onAction,
  });
}

void _initState(Action action, Context<SplashState> ctx) {
  _initAnimation(ctx);
}

void _dispose(Action action, Context<SplashState> ctx) {
  ctx.state.logoAnimationController.dispose();
}

void _initLocalization(context, SettingsState data) async {
  Locale locale;

  if ((data == null || data.language == null || data.language.isEmpty || data.language == 'auto')) {
    locale = Localizations.localeOf(context);
  } else {
    if (data.language.contains('_')) {
      List curLanguage = data.language.split('_');
      locale = Locale(curLanguage[0], curLanguage[1]);
    } else {
      locale = Locale(data.language);
    }
  }

  await FlutterI18n.refresh(context, locale);
}

void _initAnimation(ctx) {
  TickerProvider tickerProvider = ctx.stfState as TickerProvider;
  ctx.state.logoAnimationController = AnimationController(duration: Duration(milliseconds: 2000), vsync: tickerProvider);

  ctx.state.logoAnimationController.forward();

  startTimer(ctx.context, () async {
    SettingsState settingsData = await initSettings();
    String page = 'home_page';

    if (settingsData == null || settingsData.userId.isEmpty) {
      page = 'login_page';
    } else {
      Dao.baseUrl = Sys.superNodes[settingsData.superNode];
      Dao.token = settingsData.token;

      GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));
    }

    _initLocalization(ctx.context, settingsData);

    if (page == "home_page") await PermissionUtil.getLocationPermission();
    Navigator.pushReplacementNamed(ctx.context, page, arguments: {'superNode': page == 'home_page' ? settingsData.superNode : ''});
  });
}

void startTimer(context, Function callback) {
  var _duration = Duration(milliseconds: 3000);
  Timer(_duration, () => callback());
}

Future<SettingsState> initSettings() async {
  SettingsDao settingsDao = SettingsDao();
  await settingsDao.open();
  SettingsState data = await settingsDao.getItem();
  log('initSettings', data);
  await settingsDao.close();

  return data;
}
