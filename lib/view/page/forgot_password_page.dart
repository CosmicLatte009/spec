import 'package:flutter/material.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import '../../util/app_color.dart';
import 'package:spec/view/widget/custom_input.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 32),
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
                    controller: TextEditingController(),
                    label: '이메일',
                    hint: '이메일을 입력해주세요.',
                  ),
                ),
                CustomButton(
                  // onTap: () {},
                  text: '보내기',
                  type: ButtonType.main,
                  height: 56,
                  disabled: true,
                ),
                const SizedBox(height: 113),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
