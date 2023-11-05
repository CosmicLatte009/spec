import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/util/api_routes.dart';

class ForgotPasswordController extends GetxController {
  RxBool hasValue = false.obs;
  final TextEditingController emailController = TextEditingController();

  final Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  findPassword(String email) async {
    try {
      var res = await dio.post(ApiRoutes.forgotPw, data: {
        'email': email,
      });
      if (res.statusCode == 200 && res.data["status"] == "success") {
        print(res);
      }
    } on DioException catch (e) {
      print('비밀번호 찾기 요청 실패여');
      print(e.message);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
