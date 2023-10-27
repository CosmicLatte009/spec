import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/page/signup_success_page.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import 'package:spec/view/widget/custom_input.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _signup_formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '회원가입하기',
          style: AppTextStyles.body18B(
            color: AppColor.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              '*표시는 필수입력항목입니다.',
              textAlign: TextAlign.right,
              style: AppTextStyles.body8R(
                color: AppColor.warning,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _signup_formKey,
                  child: const Column(
                    children: [
                      CustomInput(
                        label: '이름',
                        hint: '이름을 입력해주세요.',
                        isRequired: true,
                      ),
                      SizedBox(height: 8),
                      CustomInput(
                        label: '이메일',
                        hint: '이메일을 입력해주세요.',
                        isRequired: true,
                      ),
                      SizedBox(height: 8),
                      CustomInput(
                        label: '비밀번호',
                        hint: '비밀번호를 입력해주세요.',
                        type: InputType.password,
                        isRequired: true,
                      ),
                      SizedBox(height: 8),
                      CustomInput(
                        label: '휴대전화',
                        hint: '휴대폰 번호를 입력해주세요.',
                        isRequired: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomButton(
              height: 56,
              text: '회원가입하기',
              onTap: () {
                Get.to(const SignupSuccessPage());
              },
            ),
            const SizedBox(height: 114),
          ],
        ),
      ),
    );
  }
}
