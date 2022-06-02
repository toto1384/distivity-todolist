import 'dart:io';

import 'package:distivity_todolist/objects/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  String table = "todo_database";
  
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }
  
  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, table);
    return await openDatabase(path,
        version: 1,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            parentId INTEGER NOT NULL,
            dueDate TEXT NOT NULL,
            dueTime INTEGER NOT NULL
            repeatEvery INTEGER NOT NULL,
            progress INTEGER NOT NULL,
          )
          ''');
  }
  
  Future<int> insert(Todo todo) async {
    Database db = await instance.database;
    return await db.insert(table, todo.toMap());
  }

  // All of the rows are returned as a list of maps, where each map is 
  // a key-value list of columns.
  Future<List<Todo>> queryAllRows() async {
    Database db = await instance.database;
    List<Todo> todos = List();

    (await db.query(table)).forEach((f){
      todos.add(Todo.fromMap(f));
    });

    return todos;
  }

  // We are assuming here that the id column in the map is set. The other 
  // column values will be used to update the row.
  Future<int> update(Todo todo) async {
    Database db = await instance.database;
    return await db.update(table, todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  // Deletes the row specified by the id. The number of affected rows is 
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}