import 'package:b2b_project/src/controller/product_controller.dart';
import 'package:b2b_project/src/helper/enum.dart';
import 'package:b2b_project/src/screens/common_widget/custom_circle_loading.dart';
import 'package:b2b_project/src/screens/common_widget/custom_refresh_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final controller = Get.find<ProductController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProductById(productId: widget.productId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Product Details"),
      ),
      body: Obx(() => switch (controller.loadProductStatus.value) {
            ApiResponse.success => Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,

                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          spreadRadius: 0.5,
                          blurRadius: 0.5,
                          offset: Offset(0, 0.4),
                        ),
                      ],
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product ID: ${controller.product.value.id}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Product Name: ${controller.product.value.name}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Price:${controller.product.value.price}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Stock: ${controller.product.value.stock}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ApiResponse.error => CustomRefreshButton(
                onPress: () {
                  controller.fetchProductById(productId: widget.productId);
                },
              ),
            ApiResponse.loading => const CustomCircleLoading(),
          }),
    );
  }
}
