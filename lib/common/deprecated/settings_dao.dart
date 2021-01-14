// import 'package:supernodeapp/global_store/action.dart';
// import 'package:supernodeapp/global_store/store.dart';
// import 'package:supernodeapp/page/settings_page/state.dart';

// import 'dart:io';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// @deprecated
// class DbDao {
//   Database db;
//   final String dataBase = 'mxc';

//   static const String usersTable = 'users';
//   static const String cId = 'cId';
//   static const String id = 'id';
//   static const String username = 'username';
//   static const String password = 'password';
//   static const String token = 'token';
//   static const String isAdmin = 'isAdmin';
//   static const String isActive = 'isActive';
//   static const String isDemo = 'isDemo';
//   static const String email = 'email';
//   static const String note = 'note';
//   static const String settingId = 'settingsId_20200413';
//   static const String settingsTable = 'settings';
//   static const String userId = 'userId';
//   static const String organizationId = 'organizationId';
//   static const String notification = 'notification';
//   static const String expire = 'expire';
//   static const String language = 'language';
//   static const String theme = 'theme';

//   Future<String> initDb(String dbName) async {
//     final String databasePath = await getDatabasesPath();
//     // print(databasePath);
//     final String path = join(databasePath, dbName);

//     // make sure the folder exists
//     if (!await Directory(dirname(path)).exists()) {
//       try {
//         await Directory(dirname(path)).create(recursive: true);
//       } catch (e) {
//         print(e);
//       }
//     }

//     return path;
//   }

//   Future<void> open() async {
//     String path = await initDb(dataBase);

//     // await deleteDatabase(path);

//     db = await openDatabase(path, version: 2,
//         onCreate: (Database _db, int version) async {
//       await _db.execute('pragma foreign_keys = ON');

//       await _db.execute('''
//           create table if not exists $usersTable (
//             $cId integer primary key autoincrement,
//             $id text not null,
//             $username text null,
//             $token text null,
//             $isAdmin integer null,
//             $isActive integer null,
//             $email text not null,
//             $note text null)
//           ''');

//       await _db.execute('''
//           create table if not exists $settingsTable (
//             $cId integer primary key autoincrement,
//             $id text null,
//             $userId text null,
//             $organizationId text null,
//             $expire text null,
//             $token text null,
//             $notification integer not null,
//             $language text null,
//             $theme integer null)
//           ''');
//     });

//     //foreign key(${SettingsDao.userId}) references ${UserDao.table}(${UserDao.id}
//     // await db.execute('drop table ${UserDao.table}');
//     // await db.execute('drop table ${SettingsDao.table}');
//   }

//   Future close() async => db.close();
// }

// @deprecated
// class SettingsDao extends DbDao {
//   //local
//   static void updateLocal(settingsData) async {
//     GlobalStore.store.dispatch(GlobalActionCreator.onSettings(settingsData));

//     SettingsDao settingsDao = SettingsDao();
//     await settingsDao.open();
//     await settingsDao.update(settingsData);
//     await settingsDao.close();
//   }

//   @override
//   Future<void> open() async {
//     await super.open();

//     List hasColumns = await db.rawQuery('''
//       select * from sqlite_master where name = "${DbDao.settingsTable}" and sql like "%${DbDao.username}%"
//     ''');

//     if (hasColumns == null || hasColumns.isEmpty) {
//       await db.execute('''
//         alter table ${DbDao.settingsTable} add ${DbDao.username} text null
//       ''');
//     }
//   }

//   Future<SettingsState> getItem() async {
//     List<Map> maps = await db.query(DbDao.settingsTable,
//         columns: [
//           DbDao.cId,
//           DbDao.userId,
//           DbDao.username,
//           DbDao.organizationId,
//           DbDao.expire,
//           DbDao.token,
//           DbDao.notification,
//           DbDao.language,
//           DbDao.theme
//         ],
//         where: '${DbDao.id} = ?',
//         whereArgs: [DbDao.settingId]);

//     if (maps.length > 0) {
//       return SettingsState.fromMap(maps.first);
//     }

//     return null;
//   }

//   Future<SettingsState> update(SettingsState item) async {
//     item.id = DbDao.settingId;
//     SettingsState res = await getItem();
//     if (res == null) {
//       await db.insert(DbDao.settingsTable, item.toMap());
//     } else {
//       await db.update(DbDao.settingsTable, item.toMap(),
//           where: '${DbDao.id} = ?', whereArgs: [DbDao.settingId]);
//     }
//     return item;
//   }

//   Future<void> migrate() async {
//     SettingsDao settingsDao = SettingsDao();
//     await settingsDao.open();
//     SettingsState data = await settingsDao.getItem();
//     await settingsDao.close();
//   }
// }
