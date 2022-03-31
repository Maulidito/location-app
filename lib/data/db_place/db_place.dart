import 'package:flutter/widgets.dart';
import 'package:location_app/data/db_sqlite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBPlace extends DbSqlite {
  final String _tableName = "user_places";
  final String _columnId = "id";
  final String _columnTitle = "title";
  final String _columnImage = "image";
  final String _columnlat = "lat";
  final String _columnlong = "long";

  @override
  Future<Database> database() async {
    final databasesPath = await sql.getDatabasesPath();
    final sqlDb = await sql.openDatabase(path.join(databasesPath, "places.db"),
        onCreate: (db, version) {
          db.execute(
              "CREATE TABLE $_tableName ($_columnId TEXT PRIMARY KEY, $_columnTitle TEXT, $_columnImage TEXT, $_columnlat TEXT, $_columnlong TEXT)");
        },
        version: 2,
        onUpgrade: (Database db, int oldVersion, int newVersion) {
          switch (oldVersion) {
            case 1: //version 2
              db.execute("DROP TABLE IF EXISTS $_tableName");
              db.execute(
                  "CREATE TABLE $_tableName ($_columnId TEXT PRIMARY KEY, $_columnTitle TEXT, $_columnImage TEXT, $_columnlat TEXT, $_columnlong TEXT)");
              break;
            default:
          }
        });
    return sqlDb;
  }

  @override
  Future<void> insert(String table, Map<String, Object> data) async {
    final db = await database();
    debugPrint("check data before insert to Db $data");
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  @override
  Future<List<Map<String, Object?>>> getData(String table) async {
    final db = await database();

    return await db.query(table);
  }

  @override
  Future<List<Map<String, Object?>>> getOneData(String table, String id) async {
    final db = await database();
    return await db.query(
      table,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
}
