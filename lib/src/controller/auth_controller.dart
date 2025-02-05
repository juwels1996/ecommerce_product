import 'package:get/get.dart';

import '../database/user_db.dart';
import '../model/user.dart';
import '../utils/util.dart';

class AuthController extends GetxController {
  final isLoginLoading = false.obs;
  final isRegisterLoading = false.obs;
  final isLogoutLoading = false.obs;

  final user = User().obs;

  Future<bool> login(
      {required String userName, required String password}) async {
    isLoginLoading(true);
    try {
      final user = await UserDB().login(userName, password);
      if (user != null) {
        this.user.value = user;
        showMassage("Login success", isSuccess: true);
        return true;
      } else {
        showMassage("Invalid username or password");
        return false;
      }
    } catch (e) {
      showMassage("Failed to login : $e");
      return false;
    } finally {
      isLoginLoading(false);
    }
  }

  Future<bool> register({required User user}) async {
    isRegisterLoading(true);
    try {
      final id = await UserDB().signUp(user);
      if (id == -1) {
        showMassage("Failed to register");
        return false;
      }
      showMassage("Register success", isSuccess: true);
      return true;
    } catch (e) {
      showMassage("Failed to register : $e");
      return false;
    } finally {
      isRegisterLoading(false);
    }
  }
}
