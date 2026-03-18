import 'package:get/state_manager.dart';

class Logincontroller extends GetxController {
  var username;
  var password;
  var isPasswordVisible = false.obs;
  bool login(user, pass) {
    username = user;
    password = pass;
    if (username == "admin" && password == "12345") {
      return true;
    } else {
      return false;
    }
  }

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible();
  }
}
