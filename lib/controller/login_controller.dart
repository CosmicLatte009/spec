import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var pwController = TextEditingController();

  final AuthController _authController = Get.find<AuthController>();
  login() {
    Get.find<AuthController>().login(emailController.text, pwController.text);
  }

  RxInt get isLoggedInState => _authController.isLoggedIn;
}
