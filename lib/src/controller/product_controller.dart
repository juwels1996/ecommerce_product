import 'package:b2b_project/src/database/product_db.dart';
import 'package:b2b_project/src/helper/enum.dart';
import 'package:b2b_project/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product.dart';

class ProductController extends GetxController {
  final loadAllProductStatus = ApiResponse.loading.obs;
  final productList = <Product>[].obs;

  final loadProductStatus = ApiResponse.loading.obs;
  final product = Product().obs;

  final isCreateProductLoading = false.obs;
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();

  @override
  void onInit() {
    create10Product();
    super.onInit();
  }

  Future<void> create10Product() async {
    for (int i = 0; i < 10; i++) {
      Product product = Product(
        name: "Product $i",
        price: 100.0 + i,
        stock: 5,
      );
      await ProductDB().createProduct(product);
    }
  }

  void fetchAllProduct() async {
    loadAllProductStatus(ApiResponse.loading);
    try {
      final products = await ProductDB().getAllProducts();
      productList.value = products;
      loadAllProductStatus(ApiResponse.success);
    } catch (e) {
      showMassage("Failed to fetch products : $e");
      loadAllProductStatus(ApiResponse.error);
    }
  }

  void fetchProductById({required int productId}) async {
    loadProductStatus(ApiResponse.loading);
    try {
      final product = await ProductDB().getProductById(productId);
      if (product != null) {
        this.product.value = product;
        loadProductStatus(ApiResponse.success);
      } else {
        loadProductStatus(ApiResponse.error);
      }
    } catch (e) {
      showMassage("Failed to fetch product : $e");
      loadProductStatus(ApiResponse.error);
    }
  }

  Future<bool> createProduct({required Product product}) async {
    isCreateProductLoading(true);
    try {
      final id = await ProductDB().createProduct(product);
      if (id == -1) {
        showMassage("Failed to create product");
        return false;
      }
      showMassage("Product created successfully", isSuccess: true);
      isCreateProductLoading(false);
      fetchAllProduct();
      return true;
    } catch (e) {
      showMassage("Failed to create product : $e");
      isCreateProductLoading(false);
      return false;
    }
  }
}
