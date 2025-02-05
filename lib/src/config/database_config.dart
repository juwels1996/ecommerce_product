import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../helper/constant.dart';

class DatabaseConfig {
  static final DatabaseConfig _instance = DatabaseConfig._internal();

  DatabaseConfig._internal();

  factory DatabaseConfig() => _instance;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $userTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE,
        email TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $productTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price REAL,
        stock INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $orderTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerId INTEGER,
        status TEXT,
        createdAt TEXT,
        totalPrice REAL,
        FOREIGN KEY (customerId) REFERENCES $userTable (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE $orderItemsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        orderId INTEGER,
        productId INTEGER,
        quantity INTEGER,
        FOREIGN KEY (orderId) REFERENCES $orderTable (id),
        FOREIGN KEY (productId) REFERENCES $productTable (id)
      )
    ''');
  }
}
