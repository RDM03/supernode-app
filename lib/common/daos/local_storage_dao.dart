import 'dart:convert';

import 'package:supernodeapp/common/utils/storage_manager_native.dart';

class LocalStorageDao {

  /// boolean field - if DHX token should be included in user's wallet
  static const walletDHX = 'walletDHX';
  /// Key for mining power UI loader and for saving mining power value between sessions
  static const miningPowerKey = 'miningPower';
  /// Key for DHX balance UI loader and for saving DHX balance value between sessions
  static const balanceDHXKey = 'balanceDHX';
  /// Key for locked amount / totalRevenueDHX / mPower UI loader and for saving locked amount value between sessions
  static const lockedAmountKey = 'lockedAmount';
  /// Key for saving total revenue DHX value between sessions
  static const totalRevenueDHXKey = 'totalRevenueDHX';
  /// Key for saving mPower value between sessions
  static const mPowerKey = 'mPower';

  static void saveUserData(String name, Map data) {
    final existed = loadUserData(name);
    if (existed != null) {
      data = {...existed, ...data};
    }
    String jsonData = jsonEncode(data);
    StorageManager.sharedPreferences.setString(name, jsonData);
  }

  static Map<String, dynamic> loadUserData(String name) {
    String data = StorageManager.sharedPreferences.getString(name);
    return data == null ? null : jsonDecode(data);
  }

  static void deleteUserData(String name) {
    StorageManager.sharedPreferences.remove(name);
  }
}
