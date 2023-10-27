import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var pwController = TextEditingController();

  // RxString 타입을 사용하여 에러 메시지를 관리
  void onEmailChanged() {
    if (emailController.text.isEmpty && pwController.text.isEmpty) {
      // 에러 상태 초기화
      isLoggedInState.value = -1;
      // 예: controller.isLoggedInState.value = someDefaultValue;
    }
  }

  final AuthController _authController = Get.find<AuthController>();
  login() {
    Get.find<AuthController>().login(emailController.text, pwController.text);
  }

  RxInt get isLoggedInState => _authController.isLoggedIn;
}
