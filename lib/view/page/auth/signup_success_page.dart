import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/page/me/profile_edit_page.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class SignupSuccessPage extends StatelessWidget {
  const SignupSuccessPage({super.key});
  static const route = '/signup/success';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/Graphic3.png'),
                  const SizedBox(height: 8),
                  Text(
                    '환영합니다!',
                    style: AppTextStyles.header24(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SPACE와 함께해봐요!',
                    style: AppTextStyles.body16R(
                      color: AppColor.black40,
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              text: '프로필 작성하기',
              height: 56,
              onTap: () {
                Get.to(const ProfileEditPage());
              },
            ),
            const SizedBox(height: 114),
          ],
        ),
      ),
    );
  }
}
