import 'package:b2b_project/src/helper/extention.dart';
import 'package:b2b_project/src/screens/order_details_screen/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/order.dart';
import '../../../utils/util.dart';

class OrderHistoryItem extends StatelessWidget {
  final Order order;

  const OrderHistoryItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>OrderDetailsScreen(orderId: order.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              blurRadius: 0.5,
              offset: Offset(0, 0.4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: ${order.id}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Date: ${formatIsoToCustomDate(order.createdAt)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Items: ${order.products.length}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Total: ${order.totalPrice}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),

              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Status: ${order.status}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
