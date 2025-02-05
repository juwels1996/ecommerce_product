import 'package:b2b_project/src/controller/product_controller.dart';
import 'package:b2b_project/src/helper/enum.dart';
import 'package:b2b_project/src/screens/common_widget/custom_circle_loading.dart';
import 'package:b2b_project/src/screens/common_widget/custom_no_list_found.dart';
import 'package:b2b_project/src/screens/common_widget/custom_refresh_button.dart';
import 'package:b2b_project/src/screens/product_list_screen/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/order_controller.dart';
import '../../model/product.dart';
import '../cart_screen/cart_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final controller = Get.find<ProductController>();
  final orderController = Get.find<OrderController>();
  final ProductController controllers = Get.find<ProductController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchAllProduct();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Products"),
        actions: [
          // Cart icon with total items in the cart
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.to(() => CartScreen());
                },
              ),
              Positioned(
                right: 6,
                top: 6,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Obx(() => Text(
                        '${orderController.totalCartItems()}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )),
                ),
              ),
            ],
          )
        ],
      ),
      body: Obx(() => switch (controller.loadAllProductStatus.value) {
            ApiResponse.success => controller.productList.isEmpty
                ? const CustomNoListFount(msg: "No Product found")
                : ListView.builder(
                    itemCount: controller.productList.length,
                    itemBuilder: (context, index) =>
                        ProductItem(product: controller.productList[index]),
                  ),
            ApiResponse.error => CustomRefreshButton(
                onPress: () {
                  controller.fetchAllProduct();
                },
              ),
            ApiResponse.loading => const CustomCircleLoading(),
          }),
      floatingActionButton: ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade100),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Create Product'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: controllers.nameController,
                          decoration: InputDecoration(
                            hintText: 'Product Name',
                          ),
                        ),
                        TextField(
                          controller: controllers.priceController,
                          decoration: InputDecoration(
                            hintText: 'Product Price',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: controllers.stockController,
                          decoration: InputDecoration(
                            hintText: 'Product Stock',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                    actions: [
                      Obx(() => controller.isCreateProductLoading.value
                          ? const CustomCircleLoading()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade50),
                              onPressed: () async {
                                // Validate the inputs
                                if (controllers
                                        .nameController.text.isNotEmpty &&
                                    controllers
                                        .priceController.text.isNotEmpty &&
                                    controllers
                                        .stockController.text.isNotEmpty) {
                                  // Create the product

                                  String name = controllers.nameController.text;
                                  double price = double.parse(
                                      controllers.priceController.text);
                                  int stock = int.parse(
                                      controllers.stockController.text);

                                  Product newProduct = Product(
                                      name: name, price: price, stock: stock);
                                  final status = await controllers.createProduct(
                                      product: newProduct);
                                  if(status){
                                    Get.back();
                                    controller.nameController.clear();
                                    controller.priceController.clear();
                                    controller.stockController.clear();

                                  }

                                } else {
                                  Get.snackbar(
                                      "Error", "Please fill in all fields.",
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              },
                              child: Text('Submit Product'),
                            )),
                    ],
                  );
                });
          },
          child: Text("Product Create")),
    );
  }
}
