import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/network_util.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/shared_preferences_helper.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/module/base/model_manager.dart';

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
  bool _isInit = true;

  bool get isInit => _isInit;

  Future<void> init(BuildContext context) async {
    if (_onInit) return;
    _onInit = true;
    await NetworkUtil.instance.refresh();
    try {
      ScreenUtil.instance.init(Config.BLUE_PRINT_WIDTH, Config.BLUE_PRINT_HEIGHT, context);
      if (!(ModelManager?.instance?.localLoadComplete ?? false)) await _localLoadStore();
      if (!(ModelManager?.instance?.networkLoadComplete ?? false) && NetworkUtil.instance.hasNet) await _networkLoadStore();
    } finally {
      L.dTag(
          "App Init",
          "Init Status: \n"
              "Screen Query: ${ScreenUtil.instance.isInit()}\n"
              "Local Data: ${(ModelManager?.instance?.localLoadComplete ?? false)}\n"
              "Network Data: ${(ModelManager?.instance?.networkLoadComplete ?? false)}\n");
      _onInit = false;
    }
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
      ModelManager.instance
        ..register(
          models: [
            GlobalStore.state.superModel,
          ]
        );
      await SharedPreferenceHelper.init();
      await ModelManager.instance.onLocalLoading();
    } catch (e) {
      L.dTag("本地初始化错误(model)", "$e");
    }
    return;
  }
}
