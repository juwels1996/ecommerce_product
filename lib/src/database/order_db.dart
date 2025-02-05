import 'package:b2b_project/src/database/product_db.dart';
import 'package:sqflite/sqflite.dart';

import '../config/database_config.dart';
import '../helper/constant.dart';
import '../model/order.dart';
import '../model/product.dart';
import 'user_db.dart';

class OrderDB {
  final productDB = ProductDB();

  Future<int> createOrder(Order order) async {
    final db = await DatabaseConfig().database;

    double totalPrice = 0.0;
    for (int i = 0; i < order.products.length; i++) {
      totalPrice += order.products[i].price * order.quantities[i];
    }

    return await db.transaction((txn) async {
      int orderId = await txn.insert(
        orderTable,
        {
          'customerId': order.customerId,
          'status': 'pending',
          'createdAt': DateTime.now().toIso8601String(),
          'totalPrice': totalPrice,
        },
      );
      for (int i = 0; i < order.products.length; i++) {
        Product product = order.products[i];
        int quantity = order.quantities[i];
        await _adjustProductStock(txn, product.id, quantity);
        await txn.insert(
          orderItemsTable,
          {
            'orderId': orderId,
            'productId': product.id,
            'quantity': quantity,
          },
        );
      }

      return orderId;
    });
  }


  Future<List<Order>> getOrdersByUserId(int userId) async {
    final db = await DatabaseConfig().database;

    final ordersResult = await db.query(
      orderTable,
      where: 'customerId = ?',
      whereArgs: [userId],
    );

    if (ordersResult.isEmpty) {
      return [];
    }

    List<Order> orders = [];

    for (var orderJson in ordersResult) {
      int orderId = orderJson['id'] as int;
      final itemsResult = await db.query(
        orderItemsTable,
        where: 'orderId = ?',
        whereArgs: [orderId],
      );
      List<Product> products = [];
      List<int> quantities = [];
      for (var item in itemsResult) {
        int productId = item['productId'] as int;
        int quantity = item['quantity'] as int;
        final product = await productDB.getProductById(productId);
        if (product != null) {
          products.add(product);
          quantities.add(quantity);
        }
      }
      Order order = Order(
        id: orderId,
        customerId: orderJson['customerId'] as int,
        products: products,
        quantities: quantities,
        status: orderJson['status'] as String,
        createdAt: orderJson['createdAt'] as String,
        totalPrice: (orderJson['totalPrice'] as num).toDouble(),
      );

      // Add the order to the list
      orders.add(order);
    }

    return orders;
  }

  Future<Order?> getOrderById(int id) async {
    final db = await DatabaseConfig().database;

    final orderResult = await db.query(
      orderTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (orderResult.isEmpty) {
      return null;
    }

    final orderJson = orderResult.first;

    final itemsResult = await db.query(
      orderItemsTable,
      where: 'orderId = ?',
      whereArgs: [id],
    );

    List<Product> products = [];
    List<int> quantities = [];

    for (var item in itemsResult) {
      int productId = item['productId'] as int;
      int quantity = item['quantity'] as int;

      final product = await productDB.getProductById(productId);
      if (product != null) {
        products.add(product);
        quantities.add(quantity);
      }
    }

    return Order(
      id: id,
      customerId: orderJson['customerId'] as int,
      products: products,
      quantities: quantities,
      status: orderJson['status'] as String,
      createdAt: orderJson['createdAt'] as String,
      totalPrice: (orderJson['totalPrice'] as num).toDouble(),
    );
  }

  Future<void> _adjustProductStock(
      Transaction txn, int productId, int quantity) async {
    final productResult = await txn.query(
      productTable,
      where: 'id = ?',
      whereArgs: [productId],
    );

    if (productResult.isEmpty) {
      throw Exception('Product not found');
    }

    final currentStock = productResult.first['stock'] as int;

    if (currentStock < quantity) {
      throw Exception('Insufficient stock for product ID $productId');
    }

    await txn.update(
      productTable,
      {'stock': currentStock - quantity},
      where: 'id = ?',
      whereArgs: [productId],
    );
  }
}
