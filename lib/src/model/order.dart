import 'package:b2b_project/src/model/product.dart';

class Order {
  final int id;
   int customerId;
  final List<Product> products;
  final List<int> quantities;
  final String status;
  final String createdAt;
  final double totalPrice;

  Order({
    this.id = 0,
    this.customerId = 0,
    required this.products,
    required this.quantities,
    this.status = '',
    this.createdAt = '',
    this.totalPrice = 0,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      customerId: json['customerId'] ?? 0,
      products: json['products'] != null ? (json['products'] as List)
          .map((e) => Product.fromJson(e))
          .toList() : [],
      quantities: List<int>.from(json['quantities'] ?? []),
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      totalPrice: json['totalPrice'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'productIds': products.map((e) => e.id).toList(),
      'quantities': quantities,
      'status': status,
    };
  }
}
