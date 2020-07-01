import 'package:shared_preferences/shared_preferences.dart';

import 'log.dart';

/// shared_preferences_helper
/// @author : linwentao
/// @date : 2019/9/29
class SharedPreferenceHelper {
  static const String TAG = "SharedPreferenceHelper";
  static SharedPreferences _preferences;
  final String mode;

  SharedPreferenceHelper(this.mode)
      : assert(_preferences != null,
            "$TAG: Must Execute SharedPreferenceHelper.init()");

  static Future<void> init() async {
    if (_preferences != null) return;
    _preferences = await SharedPreferences.getInstance();
    L.dTag(TAG, "SP init success");
  }

  static Future<bool> clear() {
    return _preferences.clear();
  }

  Future<bool> put(String key, dynamic value) {
    var mKey = "$mode\_$key";
    if (value is String)
      return _preferences.setString(mKey, value);
    else if (value is double)
      return _preferences.setDouble(mKey, value);
    else if (value is int)
      return _preferences.setInt(mKey, value);
    else if (value is bool)
      return _preferences.setBool(mKey, value);
    else if (value is List<String>)
      return _preferences.setStringList(mKey, value);
    else
      return Future.value(false);
  }

  dynamic get(String key) {
    return _preferences.getString("$mode\_$key");
  }

  bool contains(String key) {
    return _preferences.containsKey("$mode\_$key");
  }

  Future<bool> remove(String key) {
    return _preferences.remove("$mode\_$key");
  }

  String getString(String key) {
    return _preferences.getString("$mode\_$key");
  }

  List<String> getStringList(String key) {
    return _preferences.getStringList("$mode\_$key");
  }

  double getDouble(String key) {
    return _preferences.getDouble("$mode\_$key");
  }

  int getInt(String key) {
    return _preferences.getInt("$mode\_$key");
  }

  bool getBool(String key) {
    return _preferences.getBool("$mode\_$key");
  }
}
