import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth/auth_controller.dart';

class ChangePWController extends GetxController {
  final AuthController _authController = AuthController();

  final formKey = GlobalKey<FormState>();

  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  final RxBool _currentPasswordHasValue = false.obs;
  RxBool get currentPasswordHasValue => _currentPasswordHasValue;

  final RxBool _newPasswordHasValue = false.obs;
  RxBool get newPasswordHasValue => _newPasswordHasValue;

  final RxBool _buttonEnabled = false.obs;
  RxBool get buttonEnabled => _buttonEnabled;

  final RxBool _isSuccess = false.obs;
  RxBool get isSuccess => _isSuccess;

  checkButtonEnabled() {
    _buttonEnabled.value =
        currentPassword.text.isNotEmpty && newPassword.text.isNotEmpty;
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  changePassword() async {
    _isSuccess.value = await _authController.changePassword(
        currentPassword.text, newPassword.text);
    if (isSuccess.isTrue) {
      currentPassword.clear();
      newPassword.clear();
    }
  }

  @override
  void onInit() {
    super.onInit();
    currentPassword.addListener(checkButtonEnabled);
    newPassword.addListener(checkButtonEnabled);
  }

  @override
  void onClose() {
    currentPassword.dispose();
    newPassword.dispose();
    super.onClose();
  }
}
