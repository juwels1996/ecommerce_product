// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart'; // Using GetX for state management
//
// import '../../controller/product_controller.dart';
// import '../../model/product.dart';
// // Assuming you have a Product model
//
// class ProductCreateScreen extends StatelessWidget {
//   ProductCreateScreen({super.key});
//
//   // Initialize the controller
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Product'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text('Product Create Screen'),
//             IconButton(
//               onPressed: () {
//                 // Show the dialog to create the product
//                 showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: Text('Create Product'),
//                         content: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             TextField(
//                               controller: controllers.idController,
//                               decoration: InputDecoration(
//                                 hintText: 'Product Id',
//                               ),
//                             ),
//                             TextField(
//                               controller: controllers.nameController,
//                               decoration: InputDecoration(
//                                 hintText: 'Product Name',
//                               ),
//                             ),
//                             TextField(
//                               controller: controllers.priceController,
//                               decoration: InputDecoration(
//                                 hintText: 'Product Price',
//                               ),
//                               keyboardType: TextInputType.number,
//                             ),
//                             TextField(
//                               controller: controllers.stockController,
//                               decoration: InputDecoration(
//                                 hintText: 'Product Stock',
//                               ),
//                               keyboardType: TextInputType.number,
//                             ),
//                           ],
//                         ),
//                         actions: [
//                           ElevatedButton(
//                             onPressed: () {
//                               // Validate the inputs
//                               if (controllers.idController.text.isNotEmpty &&
//                                   controllers.nameController.text.isNotEmpty &&
//                                   controllers.priceController.text.isNotEmpty &&
//                                   controllers.stockController.text.isNotEmpty) {
//                                 // Create the product
//                                 int id = int.parse(controllers.idController.text);
//                                 String name = controllers.nameController.text;
//                                 double price = double.parse(controllers.priceController.text);
//                                 int stock = int.parse(controllers.stockController.text);
//
//                                 Product newProduct = Product(id: id, name: name, price: price, stock: stock);
//
//                                 // Call the createProduct method from the controller
//                                 controllers.createProduct(product: newProduct).then((success) {
//                                   if (success) {
//                                     Get.snackbar("Success", "Product created successfully!",
//                                         snackPosition: SnackPosition.BOTTOM);
//                                   } else {
//                                     Get.snackbar("Error", "Failed to create product.",
//                                         snackPosition: SnackPosition.BOTTOM);
//                                   }
//                                   Navigator.pop(context); // Close the dialog
//                                 });
//                               } else {
//                                 Get.snackbar("Error", "Please fill in all fields.",
//                                     snackPosition: SnackPosition.BOTTOM);
//                               }
//                             },
//                             child: Text('Create Product'),
//                           ),
//                         ],
//                       );
//                     });
//               },
//               icon: Icon(
//                 Icons.create_outlined,
//                 size: 20.sp,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
