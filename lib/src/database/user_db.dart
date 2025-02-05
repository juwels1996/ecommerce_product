import 'package:sqflite/sqflite.dart';

import '../config/database_config.dart';
import '../helper/constant.dart';
import '../model/user.dart';

class UserDB {
  Future<int> signUp(User user) async {
    final db = await DatabaseConfig().database;

    try {
      return await db.insert(
        userTable,
        user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        throw Exception('Username already exists');
      } else {
        throw e;
      }
    }
  }

  Future<User?> login(String name, String password) async {
    final db = await DatabaseConfig().database;

    final result = await db.query(
      userTable,
      where: 'name = ? AND password = ?',
      whereArgs: [name, password],
    );

    if (result.isNotEmpty) {
      return User.fromJson(result.first);
    } else {
      return null;
    }
  }
}
