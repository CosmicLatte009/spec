import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/signup_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import 'package:spec/view/widget/custom_input.dart';

import '../../widget/navigation/nav_menu.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});
  static const route = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(
      //     '회원가입하기',
      //     style: AppTextStyles.body18B(
      //       color: AppColor.black,
      //     ),
      //   ),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 78),
          const NavMenu(title: '회원가입하기', titleDirection: TitleDirection.center),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '*표시는 필수입력항목입니다.',
              textAlign: TextAlign.right,
              style: AppTextStyles.body8R(
                color: AppColor.warning,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: controller.signupFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      CustomInput(
                        label: '이름',
                        hint: '이름을 입력해주세요.',
                        isRequired: true,
                        controller: controller.name,
                        validator: (String? value) {
                          if (value == null || value == '') {
                            return '이름을 입력해주세요.';
                          }
                          if (value.contains(RegExp(r'\s+'))) {
                            return '공백을 포함할 수 없습니다.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      CustomInput(
                        label: '이메일',
                        hint: '이메일을 입력해주세요.',
                        isRequired: true,
                        controller: controller.mail,
                        validator: (String? value) {
                          if (value == null || value == '') {
                            return '이메일을 입력해주세요.';
                          }
                          if (!RegExp(
                                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(value)) return '올바른 이메일 형식이 아닙니다.';
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      CustomInput(
                        label: '비밀번호',
                        hint: '비밀번호를 입력해주세요.',
                        type: InputType.password,
                        isRequired: true,
                        controller: controller.password,
                        validator: (String? value) {
                          if (value == null || value == '') {
                            return '비밀번호를 입력해주세요.';
                          } else if (value.length < 8) {
                            return '8자리 이상으로 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      CustomInput(
                        label: '휴대전화',
                        hint: '휴대폰 번호를 입력해주세요.',
                        isRequired: true,
                        controller: controller.phone,
                        validator: (String? value) {
                          if (value == null || value == '') {
                            return '휴대폰 번호를 입력해주세요.';
                          }
                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                            return '숫자만 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CustomButton(
                disabled: !controller
                    .isAllInputHasValue, //모든 input값에 value가 입력되었을때 false값을 가짐.
                height: 56,
                text: '회원가입하기',
                onTap: !controller.isAllInputHasValue
                    ? null
                    : () {
                        if (controller.signupFormKey.currentState!.validate()) {
                          controller.callSignup();
                        }
                      },
              ),
            ),
          ),
          const SizedBox(height: 114),
        ],
      ),
    );
  }
}
