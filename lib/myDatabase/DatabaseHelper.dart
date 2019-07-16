import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../myDatabase/myModels/Model.dart';

class DatabaseHelper{
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 4;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);

        // If you want to want to upgrade the tables using other than increasing
        // database version
        // version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Wallets (
        _id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        initialAmount REAL NOT NULL,
        color TEXT NOT NULL,
        currency TEXT NOT NULL
      )
  ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Transactions (
        _id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        amount REAL NOT NULL,
        walletId INTEGER NOT NULL,
        categoryId INTEGER,
        transactionType INTEGER NOT NULL,
        dateTime TEXT
      )
  ''');

  }

  // void _onUpgrade(Database db, int oldVersion, int newVersion) {
  //   if (oldVersion < newVersion) {
  //     db.execute("ALTER TABLE Transactions ADD COLUMN dateTime TEXT;");
  //   }
  // }

  Future<int> insert(String tableName, Model model) async {
    Database db = await database;
    int id = await db.insert(tableName, model.toMap());
    return id;
  }

  Future<int> update(String tableName, Model model, int rowId) async{
    Database db = await database;
    return await db.update(tableName, model.toMap(), where: "${model.getDbColumns()[0]} = ?", whereArgs: [rowId]);
  }

  Future<Model> query(int id, Model model) async {
    Database db = await database;
    List<Map> maps = await db.query(model.getTableName(),
        columns: model.getDbColumns(),
        where: '${model.getDbColumns()[0]} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return model.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Model>> getNRecords(int n, Model model) async{
    Database db = await database;
    List<Map> maps = await db.query(model.getTableName(),
      columns: model.getDbColumns(),
      orderBy: '${model.getDbColumns()[0]} DESC',
      limit: n,
    );
    if (maps.length > 0){
      print('getNRecords: Total records we got ${maps.length} although we needed $n');
      List<Model> models = [];
      maps.forEach((m){
        models.add(model.fromMap(m));
      });
      return models;
    }
    return [];
  }

  // List of plain models would be returned after this method
  // The developer is expected to convert the models into widgets
  // or some other format
  Future<List<Model>> queryAll(Model model, {bool reverse=false}) async{
    String order = 'ASC';
    if (reverse){
      order = 'DESC';
    }
    Database db = await database;
    List<Map> maps = await db.query(model.getTableName(),
    columns: model.getDbColumns(),
    orderBy: '${model.getDbColumns()[0]} $order'
    );
    if (maps.length > 0){
      List<Model> models = [];
      maps.forEach((m){
        models.add(model.fromMap(m));
      });
      return models;
    }
    return [];
  }

}
