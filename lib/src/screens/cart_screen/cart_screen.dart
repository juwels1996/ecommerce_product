import 'package:b2b_project/src/controller/auth_controller.dart';
import 'package:b2b_project/src/controller/order_controller.dart';
import 'package:b2b_project/src/screens/common_widget/custom_circle_loading.dart';
import 'package:b2b_project/src/screens/common_widget/custom_no_list_found.dart';
import 'package:b2b_project/src/screens/order_details_screen/order_details_screen.dart';
import 'package:b2b_project/src/screens/product_list_screen/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final controller = Get.find<OrderController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: Obx(
          () => controller.prepareOrder.value.products.isEmpty
              ? const CustomNoListFount(msg: "No product in the cart")
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            controller.prepareOrder.value.products.length,
                        itemBuilder: (context, index) => ProductItem(
                            product:
                                controller.prepareOrder.value.products[index]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => controller.isCreateOrderLoading.value
                          ? const CustomCircleLoading()
                          : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                                                    ),
                                onPressed: () async {
                                  controller.prepareOrder.value.customerId =
                                      authController.user.value.id;
                                  final id = await controller.createOrder(
                                      order: controller.prepareOrder.value);
                                  if (id >= 0) {
                                    Get.off(
                                        () => OrderDetailsScreen(orderId: id));
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(

                                        "Place Order - > ${controller.totalPrice.value}",
                                      style: context.textTheme.titleMedium!
                                          .copyWith(
                                        fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                          ),
                    )
                  ],
                ),
        ));
  }
}
