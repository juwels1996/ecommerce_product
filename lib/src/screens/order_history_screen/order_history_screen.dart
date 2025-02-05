import 'package:b2b_project/src/controller/order_controller.dart';
import 'package:b2b_project/src/helper/enum.dart';
import 'package:b2b_project/src/screens/common_widget/custom_circle_loading.dart';
import 'package:b2b_project/src/screens/common_widget/custom_no_list_found.dart';
import 'package:b2b_project/src/screens/common_widget/custom_refresh_button.dart';
import 'package:b2b_project/src/screens/order_history_screen/widget/order_history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final controller = Get.find<OrderController>();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchAllOrder(userid: authController.user.value.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: Obx(() => switch (controller.loadAllOrderStatus.value) {
            ApiResponse.success => controller.orderList.isEmpty
                ? const CustomNoListFount(msg: "No order found")
                : ListView.builder(
                    itemCount: controller.orderList.length,
                    itemBuilder: (context, index) =>
                        OrderHistoryItem(order: controller.orderList[index]),
                  ),
            ApiResponse.error => CustomRefreshButton(
                onPress: () => controller.fetchAllOrder(
                    userid: authController.user.value.id),
              ),
            ApiResponse.loading => const CustomCircleLoading(),
          }),
    );
  }
}
