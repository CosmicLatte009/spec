import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spec/controller/login_controller.dart';

import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/button_xlarge.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final RxBool isSubmitted = false.obs;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 7, child: SvgPicture.asset('assets/logo/icon_logo.svg')),
        Expanded(
          flex: 5,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildEmailField(),
                SizedBox(height: 5),
                _buildPasswordField(),
                SizedBox(height: 5),
                _buildAuxiliaryOptions(),
              ],
            ),
          ),
        ),
        Expanded(flex: 5, child: _buildLoginButton()),
      ],
    );
  }

  Widget _buildEmailField() {
    controller.emailController.addListener(controller.onEmailChanged);

    return Obx(() => _buildTextField(
          controller.emailController,
          '이메일 주소를 입력해주세요.',
          '이메일 주소가 틀립니다. 다시 한번 확인해주세요',
          _emailValidator,
        ));
  }

  Widget _buildPasswordField() {
    controller.pwController.addListener(controller.onEmailChanged);

    return Obx(() => _buildTextField(
          controller.pwController,
          '비밀번호를 입력해주세요.',
          '비밀번호가 틀립니다. 다시 한번 확인해주세요',
          _passwordValidator,
          isPassword: true,
        ));
  }

  // 공통 텍스트 필드 생성 메서드
  Widget _buildTextField(
    TextEditingController controller,
    String hintText,
    String errorMessage,
    String? Function(String?) validator, {
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      autovalidateMode: isSubmitted.value
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      decoration: _inputDecoration(hintText,
          this.controller.isLoggedInState.value == 0 ? errorMessage : null),
      validator: validator,
    );
  }

  InputDecoration _inputDecoration(String hintText, String? errorText) {
    // 중복된 코드는 이 함수 내에서 관리
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
      return '이메일을 입력해주세요.';
    } else if (!value.contains('@')) {
      return '유효한 이메일 주소를 입력해주세요.';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    } else if (value.length < 8) {
      return '비밀번호는 최소 8자 이상이어야 합니다.';
    }
    return null;
  }

  Widget _buildAuxiliaryOptions() {
    // 추가 옵션들을 그룹화
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _findPWButton(),
        Text(
          'ㅣ',
          style: TextStyle(color: Color(0xFF999999)),
        ),
        _signupButton(),
      ],
    );
  }

  Widget _signupButton() {
    return GestureDetector(
      onTap: () {},
      child: Text(
        '회원가입하기',
        style: AppTextStyles.body14M().copyWith(color: Color(0xFF999999)),
      ),
    );
  }

  Widget _findPWButton() {
    return GestureDetector(
      onTap: () {},
      child: Text(
        '비밀번호 찾기',
        style: AppTextStyles.body14M().copyWith(color: Color(0xFF999999)),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 80),
      child: ButtonXlarge(
        onTap: () {
          isSubmitted.value = true;
          if (_formKey.currentState!.validate()) {
            controller.login();
          }
        },
        text: '로그인',
      ),
    );
  }
}
