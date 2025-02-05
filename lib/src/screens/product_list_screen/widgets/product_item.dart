import 'package:b2b_project/src/model/product.dart';
import 'package:b2b_project/src/screens/product_list_screen/widgets/product_count_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/order_controller.dart';
import '../../product_details_screen/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({super.key, required this.product});

  final controller = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(productId: product.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              blurRadius: 0.5,
              offset: Offset(0, 0.4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product ID: ${product.id}',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Product Name: ${product.name}',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price: ${product.price}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Stock: ${product.stock}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Obx(() => controller.getProductQuantity(product: product) != 0
                ? ProductCountButton(
                    onNegativePress: () {
                      controller.removeProductFromOrder(product: product);
                    },
                    onPositivePress: () {
                      controller.addProductToOrder(product: product);
                    },
                    value: controller.getProductQuantity(product: product))
                : ElevatedButton(
                    onPressed: () {
                      controller.addProductToOrder(product: product);
                    },
                    child: Text("Add to card"),
                  ))
          ],
        ),
      ),
    );
  }
}
