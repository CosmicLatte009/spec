import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/view/widget/alert/300_width_icon/icon_text_with_one_button.dart';

class ChangePWController extends GetxController {
  final AuthController _authController = AuthController(); // 의존성 주입을 위한 생성자

  var currentPassword = TextEditingController();
  var newPassword = TextEditingController();

  void attemptChangePassword() async {
    _authController.attemptChangePassword(
        currentPassword.text, newPassword.text);
  }
}
