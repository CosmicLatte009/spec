import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/login_controller.dart';

import 'package:spec/view/widget/custom_input.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final isSubmitted = false.obs; // Using RxBool

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Obx(
                    () => CustomInput(
                      controller: controller.emailController,
                      type: InputType.basic,
                      hint: '이메일을 입력하세요.',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '이메일 주소를 입력하세요.';
                        } else if (value.length < 9) {
                          return '9자 이상입니다.';
                        } else if (controller.success.value != true) {
                          return '이메일을 확인해주세요.';
                        } else if (controller.success.value == true) {
                          return '성공입니다.';
                        }
                        return null;
                      },
                      isSubmitted: isSubmitted.value,
                    ),
                  ),
                  Obx(
                    () => CustomInput(
                      controller: controller.pwController,
                      type: InputType.password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '비밀번호를 입력하세요.';
                        } else if (value.length < 9) {
                          return '비밀번호는 9글자 이상이어야 합니다.';
                        } else if (controller.success != true) {
                          return '비밀번호를 확인해주세요.';
                        }
                        return null;
                      },
                      isSubmitted: isSubmitted.value,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      isSubmitted.value = true; // Using RxBool

                      if (_formKey.currentState!.validate()) {
                        print("Form is valid");
                      } else {
                        print("Form is not valid");
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Obx(
            //   () => TextField(
            //     controller: controller.emailController,
            //     decoration: InputDecoration(
            //       labelText: '이메일',
            //       errorText: controller.error.value ? '이메일이 잘못되었습니다.' : null,
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           color:
            //               controller.success.value ? Colors.blue : Colors.red,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 30),
            // Obx(
            //   () => TextField(
            //     controller: controller.pwController,
            //     decoration: InputDecoration(
            //       labelText: '비밀번호',
            //       errorText: controller.error.value ? '비밀번호가 잘못되었습니다.' : null,
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           color:
            //               controller.success.value ? Colors.blue : Colors.red,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: controller.login,
              child: Text('로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
