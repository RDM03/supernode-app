import 'dart:convert';

import 'package:supernodeapp/common/utils/storage_manager_native.dart';

class LocalStorageDao {

  /// boolean field - if DHX token should be included in user's wallet
  static const walletDHX = 'walletDHX';

  static void saveUserData(String name, Map data, {bool overwrite = false}) {
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
