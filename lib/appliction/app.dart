import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/network_util.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/shared_preferences_helper.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/global_store/action.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/module/base/model_manager.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

class App with AppLifecycle {
  factory App() => _getInstance();

  static App get instance => _getInstance();
  static App _instance;

  App._internal();

  static App _getInstance() {
    if (_instance == null) {
      _instance = new App._internal();
    }
    return _instance;
  }
}

mixin AppLifecycle {
  bool _onInit = false;
  bool _isInit = false;
  bool _isLoaded = false;

  bool get isInit => _isInit;

  Future<void> init(BuildContext context) async {
    if (_onInit) return;
    _onInit = true;
    await NetworkUtil.instance.refresh();
    await SharedPreferenceHelper.init();
    ModelManager.instance
      ..register(models: [
        GlobalStore.state.superModel,
      ]);

    try {
      ScreenUtil.instance.init(Config.BLUE_PRINT_WIDTH, Config.BLUE_PRINT_HEIGHT, context);
      if (!(ModelManager?.instance?.localLoadComplete ?? false)) await _localLoadStore();
      if (!(ModelManager?.instance?.networkLoadComplete ?? false)) await _networkLoadStore();
      if (!_isLoaded) await _load(context);
      _isInit = true;
    } catch (e) {} finally {
      L.dTag(
          "App Init",
          "Init Status: \n"
              "Screen Query: ${ScreenUtil.instance.isInit()}\n"
              "Local Data: ${(ModelManager?.instance?.localLoadComplete ?? false)}\n"
              "Network Data: ${(ModelManager?.instance?.networkLoadComplete ?? false)}\n");
      _onInit = false;
    }
  }

  Future<void> _load(BuildContext context) async {
    // model manager init

    SettingsDao settingsDao = SettingsDao();
    await settingsDao.open();
    SettingsState data = await settingsDao.getItem();
    await settingsDao.close();

    if (data != null && data.userId.isNotEmpty) {
      Dao.baseUrl = GlobalStore.state.superModel.currentNode.url;
      Dao.token = data.token;

      GlobalStore.store.dispatch(GlobalActionCreator.onSettings(data));
    }

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
    _isLoaded = true;
  }

  Future<void> _networkLoadStore() async {
    try {
      await ModelManager.instance.onNetworkDataLoading();
    } catch (e, stack) {
      L.dTag("network load: ", "$e $stack");
    }
    return;
  }

  Future<void> _localLoadStore() async {
    try {
      await ModelManager.instance.onLocalLoading();
    } catch (e) {
      L.dTag("本地初始化错误(model)", "$e");
    }
    return;
  }
}
