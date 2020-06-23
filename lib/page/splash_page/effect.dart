import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/appliction/app.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'package:supernodeapp/page/splash_page/action.dart';

import 'state.dart';

Effect<SplashState> buildEffect() {
  return combineEffects(<Object, Effect<SplashState>>{
    Lifecycle.initState: _initState,
    Lifecycle.dispose: _dispose,
    Lifecycle.build: _build,
    SplashAction.goNextPage: _goNextPage,
  });
}

void _initState(Action action, Context<SplashState> ctx) {
  TickerProvider tickerProvider = ctx.stfState as TickerProvider;
  ctx.dispatch(SplashActionCreator.initAnimate(tickerProvider));
  ctx.state.logoController.forward().then((_) {
    ctx.dispatch(SplashActionCreator.animatePlayStateChange(true));
    ctx.dispatch(SplashActionCreator.goNextPage());
  });
  App.instance.init(ctx.context).then((_) {
    ctx.dispatch(SplashActionCreator.initDataStateChange(true));
    ctx.dispatch(SplashActionCreator.goNextPage());
  });
}

void _dispose(Action action, Context<SplashState> ctx) {
  ctx.state.logoController.dispose();
}

void _build(Action action, Context<SplashState> ctx) {
  ScreenUtil.instance.init(Config.BLUE_PRINT_WIDTH, Config.BLUE_PRINT_HEIGHT, ctx.context);
}

void _goNextPage(Action action, Context<SplashState> ctx) async {
  if (ctx.state.isDataLoaded && ctx.state.isAnimatePlayed) {
    SettingsDao settingsDao = SettingsDao();
    await settingsDao.open();
    SettingsState data = await settingsDao.getItem();
    await settingsDao.close();
    if (data != null && data.userId.isNotEmpty && GlobalStore.state.superModel.currentNode != null) {
      Navigator.pushReplacementNamed(ctx.context, "home_page");
    } else {
      Navigator.pushReplacementNamed(ctx.context, "login_page");
    }
  }
}
