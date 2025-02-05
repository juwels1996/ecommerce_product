class Product {
  final int id;
  final String name;
  final double price;
  final int stock;

  Product({
     this.id = 0,
     this.name = '',
     this.price = 0,
     this.stock = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      stock: json['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
    };
  }
}
