import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';

class DbDao {
  Database db;
  final String dataBase = 'mxc';

  Future<String> initDb(String dbName) async {
    final String databasePath = await getDatabasesPath();
    // print(databasePath);
    final String path = join(databasePath, dbName);

    // make sure the folder exists
    if (!await Directory(dirname(path)).exists()) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }

    return path;
  }

  Future<void> open() async {
    String path = await initDb(dataBase);

    // await deleteDatabase(path);

    db = await openDatabase(path, version: 2, onCreate: (Database _db, int version) async {
      await _db.execute('pragma foreign_keys = ON');

      await _db.execute('''
          create table if not exists ${UserDao.table} ( 
            ${UserDao.cId} integer primary key autoincrement,
            ${UserDao.id} text not null,
            ${UserDao.username} text null,
            ${UserDao.token} text null,
            ${UserDao.isAdmin} integer null,
            ${UserDao.isActive} integer null,
            ${UserDao.email} text not null,
            ${UserDao.note} text null)
          ''');

      await _db.execute('''
          create table if not exists ${SettingsDao.table} ( 
            ${SettingsDao.cId} integer primary key autoincrement,
            ${SettingsDao.id} text null,
            ${SettingsDao.userId} text null,
            ${SettingsDao.organizationId} text null,
            ${SettingsDao.expire} text null,
            ${SettingsDao.token} text null,
            ${SettingsDao.notification} integer not null,
            ${SettingsDao.language} text null,
            ${SettingsDao.theme} integer null)
          ''');
    });

    //foreign key(${SettingsDao.userId}) references ${UserDao.table}(${UserDao.id}
    // await db.execute('drop table ${UserDao.table}');
    // await db.execute('drop table ${SettingsDao.table}');
  }

  Future close() async => db.close();
}
