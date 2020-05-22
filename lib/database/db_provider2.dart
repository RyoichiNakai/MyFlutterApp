import 'package:flutterapp/database/db_provider.dart';
import 'package:flutterapp/database/db_model2.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider extends DatabaseProvider {
  @override
  String get databaseName => 'todolist.db';

  @override
  //todo: テーブルどうやって作る？？
  createDBTable(Database database, int version, String tableName) => db.execute(
    """
          CREATE TABLE $tableName(
            "key" INTEGER PRIMARY KEY AUTOINCREMENT,
            "title" TEXT,
            "datetime" TEXT
          )
    """,
  );

  Future<void> insertList(ToDoListModel model, String tableName) async{
    await db.insert(
      tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteList(int key, String tableName) async{
    await db.delete(
      tableName,
      where: 'key = ?',
      whereArgs: [key]
    );
  }

  Future<void> updateList(ToDoListModel model, String tableName) async{
    await db.update(
      tableName,
      model.toMap(),
      where: 'key = ?',
      whereArgs: [model.key],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<List<Map<String, dynamic>>> getList(String tableName) async{
    final List<Map<String, dynamic>> maps
    = await db.query(tableName, orderBy: "key");
    return maps;
  }
}