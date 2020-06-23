import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/shared_preferences_helper.dart';
import 'package:supernodeapp/module/base/base_data.dart';

/// abstract_model
abstract class BaseModel<K extends AbstractBaseData> {
  VoidCallback _updateListener;

  set dataUpdateListener(VoidCallback update) => _updateListener = update;

  String get spPiece;

  String get spKey;

  SharedPreferenceHelper _preferenceHelper;

  SharedPreferenceHelper get sp {
    if (_preferenceHelper == null)
      _preferenceHelper = SharedPreferenceHelper(spPiece);
    return _preferenceHelper;
  }

  bool _dirty = false;

  set dirty(bool value) => _dirty = value;

  K _data;

  K get data => _data?.clone();

  K initData();

  bool _networkLoadComplete = false;

  get networkLoadComplete => _networkLoadComplete;

  bool _localLoadComplete = false;

  get localLoadComplete => _localLoadComplete;

  Future<bool> networkLoad() async => true;

  Future<bool> connectNetLoad() async {
    if (!_networkLoadComplete) {
      _networkLoadComplete = await networkLoad();
      L.dTag("BaseModel", "network data loaded");
    }
    return _networkLoadComplete;
  }

  Future<bool> localLoad() async {
    if (_localLoadComplete) return true;
    if (_data != null) return false;
    if (sp.contains(spKey)) {
      var jsonStr = sp.get(spKey);
      _data = initData();
      _data.jsonConvert(jsonDecode(jsonStr));
    } else {
      await whenLocalDataEmpty();
    }
    localLoaded();
    L.dTag("BaseModel", "local data loaded");
    _localLoadComplete = true;
    return true;
  }

  Future<bool> whenLocalDataEmpty() => null;

  void localLoaded() {}

  Future<bool> localUpdate(K data) async {
    bool result;
    try {
      _dirty = true;
      if (data == null) {
        _data = null;
        result = await clean();
      } else {
        _data = data;
        result = await sp.put(spKey, data.toJsonStr());
      }
      _updateListener?.call();
    } catch (e) {
      L.d("$e");
      result = false;
    } finally {
      _dirty = false;
    }
    return result;
  }

  Future<bool> clean() async {
    if (_dirty && sp.contains(spKey)) {
      return sp.remove(spKey);
    }
    return true;
  }

  clear() {
    sp.remove(spKey);
  }
}
