import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/changes_pw_controller.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/custom_input.dart';

import '../../widget/alert/360_width_avatar/avatar_with_one_button.dart';

class ChangePasswordPage extends GetView<ChangePWController> {
  const ChangePasswordPage({super.key});
  static const route = '/change-pw';

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bottomPadding = bottomInset > 0.0 ? 20.0 : 113.0;

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
                key: controller.formKey,
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
                            validator: (value) {
                              if (value == null || value.length < 8) {
                                return '현재 비밀번호를 다시 입력해주세요.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          CustomInput(
                            controller: controller.newPassword,
                            label: '새 비밀번호',
                            hint: '비밀번호',
                            type: InputType.password,
                            validator: (value) {
                              if (value == null || value.length < 8) {
                                return '8자리 이상으로 설정해주세요.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      bool buttonEnabled = controller.buttonEnabled.value;
                      return CustomButton(
                        onTap: buttonEnabled
                            ? () async {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  await controller.changePassword();
                                  if (controller.isSuccess.isFalse) {
                                    Future.microtask(
                                      () => showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AvatarWithOneButton(
                                            //@todo 밑에 아바타 내 아바타로 받아오도록 추후 변경
                                            // avatar:
                                            //     'assets/icons/svgs/woman-a.svg',
                                            mainMessage: '비밀번호가 변경되었습니다.',
                                            buttonTitle: '닫기',
                                          );
                                        },
                                      ).then((_) {
                                        Get.toNamed(
                                          AppPagesRoutes.login,
                                        );
                                      }),
                                    );
                                  }
                                }
                              }
                            : null,
                        text: '변경하기',
                        height: 56,
                        disabled: !buttonEnabled,
                      );
                    }),
                    SizedBox(height: bottomPadding),
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
