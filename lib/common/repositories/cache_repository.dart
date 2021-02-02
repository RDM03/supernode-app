import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheRepository {
  /// boolean field - if DHX token should be included in user's wallet
  static const walletDHX = 'walletDHX';

  /// boolean field - if BTC token should be included in user's wallet
  static const walletBTC = 'walletBTC';

  /// Key for mining power UI loader and for saving supernode mining power value between sessions
  static const miningPowerKey = 'miningPower';

  /// Key for DHX balance UI loader and for saving DHX balance value between sessions
  static const balanceDHXKey = 'balanceDHX';

  /// Key for locked amount / totalRevenueDHX / mPower UI loader and for saving locked amount value between sessions
  static const lockedAmountKey = 'lockedAmount';

  /// Key for saving total revenue DHX value between sessions
  static const totalRevenueDHXKey = 'totalRevenueDHX';

  /// Key for saving mPower value between sessions
  static const mPowerKey = 'mPower';

  /// Key for BTC balance UI loader and for saving BTC balance value between sessions
  static const balanceBTCKey = 'balanceBTC';

  SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveUserData(String name, Map data) {
    final existed = loadUserData(name);
    if (existed != null) {
      data = {...existed, ...data};
    }
    String jsonData = jsonEncode(data);
    _sharedPreferences.setString(name, jsonData);
  }

  Map<String, dynamic> loadUserData(String name) {
    String data = _sharedPreferences.getString(name);
    return data == null ? null : jsonDecode(data);
  }

  void deleteUserData(String name) {
    _sharedPreferences.remove(name);
  }
}
