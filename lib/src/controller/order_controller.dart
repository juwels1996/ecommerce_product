import 'package:b2b_project/src/utils/util.dart';
import 'package:get/get.dart';

import '../database/order_db.dart';
import '../helper/enum.dart';
import '../model/order.dart';
import '../model/product.dart';

class OrderController extends GetxController {
  final loadAllOrderStatus = ApiResponse.loading.obs;
  final orderList = <Order>[].obs;

  final loadOrderStatus = ApiResponse.loading.obs;
  final order = Order(
    products: [],
    quantities: [],
  ).obs;

  final isCreateOrderLoading = false.obs;

  final prepareOrder = Order(
    products: [],
    quantities: [],
  ).obs;
  final totalPrice = 0.0.obs;

  void addProductToOrder({required Product product}) {


    prepareOrder.update((val) {
      final index = prepareOrder.value.products
          .indexWhere((element) => element.id == product.id);

        if (index != -1) {
          if(prepareOrder.value.quantities[index]+1<= product.stock) {
            prepareOrder.value.quantities[index] += 1;
          }else{
            showMassage("Limited Stock");
          }
        } else {
          prepareOrder.value.products.add(product);
          prepareOrder.value.quantities.add(1);
        }

      totalCartPrice();
    });
  }

  void removeProductFromOrder({required Product product}) {

    prepareOrder.update((val) {
      final index = prepareOrder.value.products
          .indexWhere((element) => element.id == product.id);
      if (index != -1) {

        if(prepareOrder.value.quantities[index] > 1) {
          prepareOrder.value.quantities[index] -= 1;
        }else{
          prepareOrder.value.products.removeAt(index);
          prepareOrder.value.quantities.removeAt(index);
        }
      }
      totalCartPrice();

    });

  }

  int getProductQuantity({required Product product}) {


    final index = prepareOrder.value.products
        .indexWhere((element) => element.id == product.id);
    if (index != -1) {
      return prepareOrder.value.quantities[index];
    }
    return 0;
  }

  int totalCartItems() {
    return prepareOrder.value.products.length;
  }

  void totalCartPrice() {
    double total = 0;
    for (int i = 0; i < prepareOrder.value.products.length; i++) {
      total += prepareOrder.value.products[i].price *
          prepareOrder.value.quantities[i];
    }
    totalPrice.value = total;
  }

  void clearOrder() {
    prepareOrder.value = Order(
      products: [],
      quantities: [],
    );
  }

  void fetchAllOrder({required int userid}) async {
    loadAllOrderStatus(ApiResponse.loading);
    try {
      final orders = await OrderDB().getOrdersByUserId(userid);
      orderList.value = orders;
      loadAllOrderStatus(ApiResponse.success);
    } catch (e) {
      showMassage("Failed to fetch orders : $e");
      loadAllOrderStatus(ApiResponse.error);
    }
  }

  void fetchOrderById({required int orderId}) async {
    loadOrderStatus(ApiResponse.loading);
    try {
      final order = await OrderDB().getOrderById(orderId);
      if (order != null) {
        this.order.value = order;
        loadOrderStatus(ApiResponse.success);
      } else {
        loadOrderStatus(ApiResponse.error);
      }
    } catch (e) {
      showMassage("Failed to fetch order : $e");
      loadOrderStatus(ApiResponse.error);
    }
  }

  Future<int> createOrder({required Order order}) async {
    isCreateOrderLoading(true);
    try {
      final id = await OrderDB().createOrder(order);
      if (id == -1) {
        showMassage("Failed to create order");
        return -1;
      }
      showMassage("Order created successfully", isSuccess: true);
      clearOrder();
      return id;
    } catch (e) {
      showMassage("Failed to create order : $e");
      return -1;
    } finally {
      isCreateOrderLoading(false);
    }
  }
}
