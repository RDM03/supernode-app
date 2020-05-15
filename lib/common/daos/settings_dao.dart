import 'package:supernodeapp/common/daos/db_dao.dart';
import 'package:supernodeapp/global_store/action.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

class SettingsApi {}

class SettingsDao extends DbDao{
  static const String settingId = 'settingsId_20200413';

  static const String table = 'settings';
  static const String cId = 'cId';
  static const String id = 'id';
  static const String userId = 'userId';
  static const String username = 'username';
  static const String organizationId = 'organizationId';
  static const String token = 'token';
  static const String notification = 'notification';
  static const String expire = 'expire';
  static const String superNode = 'superNode';
  static const String language = 'language';
  static const String theme = 'theme';
  
  //local
  static void updateLocal(settingsData) async{
    GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));
    
    SettingsDao settingsDao = SettingsDao();
    await settingsDao.open();
    await settingsDao.update(settingsData);
    await settingsDao.close();
  }

  @override
  Future<void> open() async {
    await super.open();

    List hasColumns = await db.rawQuery('''
      select * from sqlite_master where name = "$table" and sql like "%$username%"
    ''');

    if(hasColumns == null || hasColumns.isEmpty){
      await db.execute('''
        alter table $table add $username text null
      ''');
    }
  
  }

  Future<SettingsState> getItem() async {
    List<Map> maps = await db.query(
      table,
      columns: [cId, userId, username, organizationId, expire, token, notification, superNode, language, theme],
      where: '$id = ?',
      whereArgs: [settingId]
    );

    if (maps.length > 0) {
      return SettingsState.fromMap(maps.first);
    }

    return null;
  }

  Future<SettingsState> update(SettingsState item) async {
    item.id = settingId;
    SettingsState res = await getItem();
    if(res == null){
      await db.insert(table, item.toMap());
    }else{
      await db.update(table, item.toMap(),
      where: '$id = ?', whereArgs: [settingId]);
    }
    return item;
  }

}