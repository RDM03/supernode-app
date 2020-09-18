import 'dart:convert';

import 'package:supernodeapp/common/utils/storage_manager_native.dart';

class LocalStorageDao {
  static void saveUserData(String name,String key,dynamic value){
    Map res = loadUserData(name);
    res[key] = value;

    String jsonData = jsonEncode(res);
    StorageManager.sharedPreferences.setString(name, jsonData);
  }

  static Map loadUserData(String name){
    String data = StorageManager.sharedPreferences.getString(name);
    return data == null || data.isEmpty ? {} : jsonDecode(data);
  }

  static void deleteUserData(String name){
    StorageManager.sharedPreferences.remove(name);
  }
}