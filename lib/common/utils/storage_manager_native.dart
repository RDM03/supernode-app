import 'dart:io';

import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supernodeapp/common/utils/currencies.dart';

class StorageManager {
  /// app全局配置 eg:theme token
  static SharedPreferences sharedPreferences;

  /// 临时目录 eg: cookie
  static Directory temporaryDirectory;

  /// 初始化必备操作 eg:user数据
  static LocalStorage localStorage;

  /// 必备数据的初始化操作
  ///
  /// 由于是同步操作会导致阻塞,所以应尽量减少存储容量
  static init() async {
    // async 异步操作
    // sync 同步操作
    temporaryDirectory = await getTemporaryDirectory();
    sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage('LocalStorage');
    await localStorage.ready;
  }

  static List<Currency> selectedCurrencies() {
    final currenciesKeys =
        StorageManager.sharedPreferences.getStringList('selected_currencies');
    if (currenciesKeys == null)
      return [
        Currency.cny,
        Currency.usd,
        Currency.rub,
        Currency.krw,
        Currency.jpy,
        Currency.eur,
        Currency.try0,
        Currency.vnd,
        Currency.idr,
        Currency.brl,
      ];
    return Currency.values
        .where((e) => currenciesKeys.contains(e.shortName))
        .toList();
  }

  static Future<void> setSelectedCurrencies(List<Currency> currencies) async {
    await StorageManager.sharedPreferences.setStringList(
      'selected_currencies',
      currencies.map((e) => e.shortName).toList(),
    );
  }
}
