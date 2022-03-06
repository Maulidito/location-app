import 'package:flutter/widgets.dart';
import 'package:location_app/data/db_sqlite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBPlace extends DbSqlite {
  final String _columnId = "id";
  final String _columnTitle = "title";
  final String _columnImage = "image";

  @override
  Future<Database> database() async {
    final databasesPath = await sql.getDatabasesPath();
    final sqlDb = await sql.openDatabase(
      path.join(databasesPath, "places.db"),
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE user_places ($_columnId TEXT PRIMARY KEY, $_columnTitle TEXT, $_columnImage TEXT)");
      },
      version: 1,
    );
    return sqlDb;
  }

  @override
  Future<void> insert(String table, Map<String, Object> data) async {
    final db = await database();
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
