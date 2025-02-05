import 'package:b2b_project/src/app.dart';
import 'package:b2b_project/src/controller/auth_controller.dart';
import 'package:b2b_project/src/helper/extention.dart';
import 'package:b2b_project/src/model/user.dart';
import 'package:b2b_project/src/screens/common_widget/custom_circle_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<AuthController>();

  final isPasswordHidden = true.obs;

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();

  // Function to handle sign-up action
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        email: _emailController.text,
        password: _passwordController.text,
        name: _userNameController.text,
      );

      final status = await controller.register(user: user);

      if (status) {
        Get.back();
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(

            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return "Email is required";
                    }
                    if (value?.isValidEmail == false) {
                      return "Email is not valid";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16),
                // Username field
                TextFormField(
                  controller: _userNameController,
                  // Controller for username field
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16),

                // Password field
            Obx(() =>TextFormField(
                  controller: _passwordController,
                  // Controller for password field
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon:  IconButton(
                          icon: Icon(
                            isPasswordHidden.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            isPasswordHidden.toggle();
                          },
                        ),
                  ),
                  obscureText: isPasswordHidden.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                )),

                SizedBox(height: 16),

                // Confirm Password field
                Obx(() => TextFormField(
                      controller: _confirmPasswordController,
                      // Controller for confirm password field
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordHidden.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            isPasswordHidden.toggle();
                          },
                        ),
                      ),
                      obscureText: isPasswordHidden.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    )),

                SizedBox(height: 32),

                // Sign-up Button
                Obx(() => controller.isRegisterLoading.value
                    ? const CustomCircleLoading()
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.blue.shade700
                  ),
                        onPressed: _signUp,
                        child: Text('Sign Up',style: TextStyle(
                          color: Colors.white
                        ),),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
