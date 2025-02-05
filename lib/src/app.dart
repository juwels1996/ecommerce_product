import 'package:b2b_project/src/controller/auth_controller.dart';
import 'package:b2b_project/src/controller/order_controller.dart';
import 'package:b2b_project/src/controller/product_controller.dart';
import 'package:b2b_project/src/screens/login_screen/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'helper/route_interceptor.dart';

class MyApp extends StatelessWidget {
  final RouteInterceptor routeInterceptor = RouteInterceptor();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ScreenUtilInit(
      designSize: Size(width, height),
      builder: (context, child) => GetMaterialApp(
          title: 'B2B',
          navigatorObservers: [routeInterceptor],
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
          initialBinding: BindingsBuilder(() {
            Get.put(AuthController());
            Get.put(ProductController());
            Get.put(OrderController());
          }),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            );
          }),
    );
  }
}
