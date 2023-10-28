import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/view/widget/alert/300_width_icon/icon_text_with_one_button.dart';

import 'auth_controller.dart';

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

  // 로그인 실패 다이얼로그 표시

  // 기타 다이얼로그 표시 메소드
  void showDialog_5(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const IconTextWithOneButton(
          svgPath: 'assets/icons/svgs/SFACE.svg',
          mainMessage: 'adsds',
          subMessage: 'sdsd',
          buttonTitle: 'sfsf',
        );
      },
    );
  }
}
