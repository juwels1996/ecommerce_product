import 'package:sqflite/sqflite.dart';

import '../config/database_config.dart';
import '../helper/constant.dart';
import '../model/product.dart';

class ProductDB{


  /// Create a new product
  Future<int> createProduct(Product product) async {
    final db = await DatabaseConfig().database;

    return await db.insert(
      productTable,
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get all products
  Future<List<Product>> getAllProducts() async {
    final db = await DatabaseConfig().database;

    final result = await db.query(productTable);

    return result.map((json) => Product.fromJson(json)).toList();
  }

  /// Get a product by ID
  Future<Product?> getProductById(int id) async {
    final db = await DatabaseConfig().database;

    final result = await db.query(
      productTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Product.fromJson(result.first);
    } else {
      return null;
    }
  }

}