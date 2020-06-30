import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';

/// NetworkUtil
/// @author : linwentao
/// @date : 2019/11/18
class NetworkUtil {
  // 默认值为wifi
  ConnectivityResult _netState = ConnectivityResult.wifi;

  List<ValueSetter<ConnectivityResult>> _listenerList = [];

  ConnectivityResult get netState => _netState;

  String get networkStr => hasNet ? _netState == ConnectivityResult.mobile ? "流量" : "wifi" : "无网络";

  bool get hasNet => _netState != null && _netState != ConnectivityResult.none;

  bool get isWifi => _netState != null && _netState == ConnectivityResult.wifi;

  bool get isMobile => _netState != null && _netState == ConnectivityResult.mobile;

  void init() async {
    if (Platform.isAndroid || Platform.isIOS) {
      refresh();
      _listenNetworkChange();
    }
  }

  Future<void> refresh() async {
    if (Platform.isAndroid || Platform.isIOS) {
      _netState = await Connectivity().checkConnectivity();
    }
  }

  void addAllListener(List<ValueSetter<ConnectivityResult>> listener) {
    _listenerList.addAll(listener);
  }

  void addListener(ValueSetter<ConnectivityResult> listener) {
    _listenerList.add(listener);
  }

  void removeListener(ValueSetter<ConnectivityResult> listener) {
    _listenerList.remove(listener);
  }

  void clearListeners(ValueSetter<ConnectivityResult> listener) {
    _listenerList.clear();
  }

  /// 监听网络状态改变
  void _listenNetworkChange() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if (_listenerList.isNotEmpty) _listenerList.forEach((onResult) => onResult(result));
      _netState = result;
    });
  }

  /// 单例
  factory NetworkUtil() => _getInstance();

  static NetworkUtil get instance => _getInstance();
  static NetworkUtil _instance;

  NetworkUtil._internal();

  static NetworkUtil _getInstance() {
    if (_instance == null) {
      _instance = new NetworkUtil._internal();
    }
    return _instance;
  }
}
