import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/view/page/signup_success_page.dart';

class SignupController extends GetxController {
  final signupFormKey = GlobalKey<FormState>();
// email(String -required) // 이메일 형식이어야 합니다. []
// password(String - required) // 8자리이상이어야 합니다. [√]
// phone(String - required) //숫자만 입력해주세요. []
// name(String - requried) //공백x []

  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  //auth
  String BASE_URL = 'https://dev.sniperfactory.com';
  String SIGNUP_PATH = '/api/auth/signup';
  Dio dio = Dio();

  signup(String name, String mail, String password, String phone) async {
    dio.options.baseUrl = BASE_URL;
    try {
      var res = await dio.post(SIGNUP_PATH, data: {
        'username': name,
        'mail': mail,
        'password': password,
        'passwordConfirm': phone,
      });
      if (res.statusCode == 200) {
        Get.to(const SignupSuccessPage());
      }
    } on DioException catch (e) {
      print('가입실패');
      print(e.message);
      print(e.response!.realUri);
    }
  }

  //signup: 추후에 signup을 auth로 이동시킬것
  callSignup() async {
    signup(
      name.text,
      mail.text,
      password.text,
      phone.text,
    );
  }
}
