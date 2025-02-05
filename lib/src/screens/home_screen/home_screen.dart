import 'package:b2b_project/src/screens/product_list_screen/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../order_history_screen/order_history_screen.dart';
import '../product_create/product_create_Screen.dart';
import 'home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'B2B Business',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Get.to(() => ProductListScreen());
              },
              child: Text('Go For Shopping'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Get.to(OrderHistoryScreen());
              },
              child: Text('Order History'),
            ),
            //now  we will create a new screen for product create
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.white,
            //   ),
            //   onPressed: () {
            //
            //    Get.to(() => ProductCreateScreen());
            //   },
            //   child: Text('Product Create'),
            // ),
          ],
        ),
      ),
    );
  }
}
