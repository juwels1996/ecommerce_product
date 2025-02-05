import 'package:b2b_project/src/controller/order_controller.dart';
import 'package:b2b_project/src/helper/enum.dart';
import 'package:b2b_project/src/helper/extention.dart';
import 'package:b2b_project/src/screens/common_widget/custom_circle_loading.dart';
import 'package:b2b_project/src/screens/common_widget/custom_refresh_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/util.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final controller = Get.find<OrderController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchOrderById(orderId: widget.orderId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order Details'),
        ),
        body: Obx(() => switch (controller.loadOrderStatus.value) {
              ApiResponse.success => SingleChildScrollView(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order ID: ${controller.order.value.id}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),

                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Date: ${formatIsoToCustomDate(controller.order.value.createdAt)}',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.black38
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),

                      Text(
                        'Total: ${controller.order.value.totalPrice}',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black38
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),

                      Text(
                        'Status: ${controller.order.value.status}',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black38
                        ),
                      ),



                      SizedBox(
                        height: 5.h,
                      ),

                      ...controller.order.value.products.mapIndexed((product, index) {
                        return Container(
                          width: double.infinity,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.grey.shade100,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.primary,
                              blurRadius: 0.5,
                              offset: const Offset(0, 0.4),
                            )
                          ],
                        ),
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w
                        ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product: ${product.name}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              Text(
                                'Quantity: ${controller.order.value.quantities[index]}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              Text(
                                'Price: ${product.price * controller.order.value.quantities[index]} ',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),


                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ApiResponse.error => CustomRefreshButton(
                  onPress: () =>
                      controller.fetchOrderById(orderId: widget.orderId)),
              ApiResponse.loading => const CustomCircleLoading(),
            }));
  }
}
