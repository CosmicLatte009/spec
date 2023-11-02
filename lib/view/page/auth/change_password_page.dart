import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/changes_pw_controller.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/custom_input.dart';

class ChangePasswordPage extends GetView<ChangePWController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 24),
          const NavMenu(
            title: '비밀번호 변경',
            titleDirection: TitleDirection.center,
          ),
          const SizedBox(height: 32),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomInput(
                            controller: controller.currentPassword,
                            label: '현재 비밀번호',
                            hint: '비밀번호',
                            type: InputType.password,
                          ),
                          const SizedBox(height: 8),
                          CustomInput(
                            controller: controller.newPassword,
                            label: '새 비밀번호',
                            hint: '비밀번호',
                            type: InputType.password,
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      onTap: () {
                        controller.attemptChangePassword();
                      },
                      text: '변경하기',
                      type: ButtonType.main,
                      height: 56,
                      //disabled: true,
                    ),
                    const SizedBox(height: 113),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
