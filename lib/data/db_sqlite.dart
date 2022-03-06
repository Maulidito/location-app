import 'package:sqflite/sqflite.dart';

abstract class DbSqlite {
  Future<Database> database();
  Future<void> insert(String table, Map<String, Object> data);
  Future<List<Map<String, Object?>>> getData(String table);
  Future<List<Map<String, Object?>>> getOneData(String table, String id);
}
