import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/forgot_pw_controller.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/alert/300_width_icon/icon_text_with_one_button.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import '../../../util/app_color.dart';
import 'package:spec/view/widget/custom_input.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});
  static const route = '/forgot-pw';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 78),
        const NavMenu(title: '비밀번호 찾기', titleDirection: TitleDirection.center),
        const SizedBox(height: 32),
        Text(
          '기존에 가입하신 이메일을 입력하시면,\n새로운 비밀번호를 보내드립니다.',
          style: AppTextStyles.body14R(color: AppColor.black60),
          textAlign: TextAlign.center,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: CustomInput(
                    controller: controller.emailController,
                    label: '이메일',
                    hint: '이메일을 입력해주세요.',
                  ),
                ),
                // Obx(() => CustomButton(
                //       onTap: controller.hasValue.value
                //           ? () {
                //               controller.findPassword(
                //                   controller.emailController.text);
                //             }
                //           : null,
                //       text: '보내기',
                //       type: ButtonType.main,
                //       height: 56,
                //       disabled: !controller.hasValue.value,
                //     )),
                Obx(() {
                  bool buttonEnabled = controller.hasValue.value;
                  return CustomButton(
                    onTap: buttonEnabled
                        ? () async {
                            await controller
                                .findPassword(controller.emailController.text);
                            if (controller.isSuccess.isTrue) {
                              Future.microtask(
                                () => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const IconTextWithOneButton(
                                      svgPath: 'assets/icons/svgs/Send.svg',
                                      mainMessage: '새로운 비밀번호를 보냈습니다!',
                                      subMessage: '메일함을 확인해주세요.',
                                      buttonTitle: '확인하기',
                                    );
                                  },
                                ).then((_) {
                                  // Dialog가 닫힐 때 실행
                                  Get.toNamed('/login');
                                  controller.isSuccess.value = false;
                                }),
                              );
                            }
                          }
                        : null,
                    text: '보내기',
                    type: ButtonType.main,
                    height: 56,
                    disabled: !buttonEnabled,
                  );
                }),
                const SizedBox(height: 113),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
