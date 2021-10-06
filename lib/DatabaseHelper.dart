import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {
  
  
  // Create necessary variables for SQLite
  static final _databaseName = "Humans.db";
  static final _databaseVersion = 1;
  static final table = 'humanData';


  // Create column variables
  static final columnName = 'name';
  static final columnBirth = 'birthday';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnName TEXT PRIMARY,
            $columnBirth TEXT,
          )
          ''');
  }

  // Helper methods

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.rawQuery("SELECT * FROM $table");
  }

  Future<List<Map<String, dynamic>>> queryByName(String name) async {
    Database db = await instance.database;
    Future<List<Map<String, dynamic>>> data =
        db.rawQuery("SELECT * FROM $table WHERE $columnName='$name'");
    return data;
  }

  // Deletes the row specified by the Name. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnName = ?', whereArgs: [id]);
  }
  
}
