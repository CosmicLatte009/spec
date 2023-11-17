import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './auth_controller.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var pwController = TextEditingController();

  final AuthController _authController = Get.find<AuthController>();

  // RxInt 타입을 사용하여 로그인 상태 관리
  RxInt get isLoggedInState => _authController.isLoggedIn;

  // 로그인 메소드
  void login() async {
    _authController.login(emailController.text, pwController.text);

    // 로그인 시도 후 결과 확인
  }

  // 이메일 변경 감지
  void onEmailChanged() {
    if (emailController.text.isEmpty && pwController.text.isEmpty) {
      // 에러 상태 초기화
      isLoggedInState.value = -1;
    }
  }
}
