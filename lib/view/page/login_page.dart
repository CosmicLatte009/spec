import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spec/controller/login_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final RxBool isSubmitted = false.obs;

  confirm() {
    if (controller.emailController == '') {
      return null;
    } else if (controller.isLoggedInState == 0) {
      return '이메일을 확인하세요.';
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icon_logo.svg'),
            _buildEmailField(),
            _buildPasswordField(),
            SizedBox(height: 20),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    controller.emailController.addListener(controller.onEmailChanged);

    return Obx(() => TextFormField(
          controller: controller.emailController,
          autovalidateMode: isSubmitted.value
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          decoration: _inputDecoration(
              '이메일 주소를 입력해주세요.',
              controller.isLoggedInState == 0
                  ? '이메일 주소가 틀립니다. 다시 한번 확인해주세요'
                  : null),
          validator: (value) => _emailValidator(value),
        ));
  }

  Widget _buildPasswordField() {
    controller.pwController.addListener(controller.onEmailChanged);

    return Obx(() => TextFormField(
          controller: controller.pwController,
          obscureText: true,
          autovalidateMode: isSubmitted.value
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          decoration: _inputDecoration(
              '비밀번호를 입력해주세요.',
              controller.isLoggedInState == 0
                  ? '비밀번호가 틀립니다. 다시 한번 확인해주세요'
                  : null),
          validator: (value) => _passwordValidator(value),
        ));
  }

  InputDecoration _inputDecoration(String hintText, String? errorText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      fillColor: AppColor.back05,
      enabledBorder: _outlineInputBorder(Colors.transparent),
      focusedBorder: _outlineInputBorder(Colors.transparent),
      errorStyle: AppTextStyles.body12R(color: AppColor.warning),
      errorBorder: _outlineInputBorder(AppColor.warning),
      focusedErrorBorder: _outlineInputBorder(AppColor.warning),
      errorText: errorText,
    );
  }

  OutlineInputBorder _outlineInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: BorderRadius.circular(10),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (controller.emailController.value == 0) {
      return '이메일 주소가 틀립니다. 다시 한번 입력해주세요.';
    }
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
      ;
    } else if (controller.pwController.value == 0) {
      return '비밀번호가 틀립니다. 다시 한번 입력해주세요.';
    }
    return null;
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        isSubmitted.value = true;
        if (_formKey.currentState!.validate()) {
          controller.login();
        }
      },
      child: Text('로그인'),
    );
  }
}
