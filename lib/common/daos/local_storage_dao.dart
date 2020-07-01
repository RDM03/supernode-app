import 'dart:convert';

import 'package:supernodeapp/common/utils/storage_manager_native.dart';

class LocalStorageDao {
  static void saveUserData(String name,Map data){
    String jsonData = jsonEncode(data);
    StorageManager.sharedPreferences.setString(name, jsonData);
  }

  static Map<String, dynamic> loadUserData(String name){
    String data = StorageManager.sharedPreferences.getString(name);
    return jsonDecode(data);
  }

  static void deleteUserData(String name){
    StorageManager.sharedPreferences.remove(name);
  }
}