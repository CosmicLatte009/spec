import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:spec/util/api_routes.dart';
import 'package:spec/view/page/signup_success_page.dart';

class SignupController extends GetxController {
  final RxBool _isAllInputHasValue = true.obs;
  final signupFormKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();

  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  getAllInputHasValue() {
    if (name.text.isEmpty ||
        mail.text.isEmpty ||
        password.text.isEmpty ||
        phone.text.isEmpty) {
      _isAllInputHasValue(false);
    } else {
      _isAllInputHasValue(true);
    }
    update();
  }

  bool get isAllInputHasValue => _isAllInputHasValue.value;

  //auth
  String baseUrl = 'https://dev.sniperfactory.com';
  Dio dio = Dio();

  setToken(String? value) async {
    await storage.write(key: 'jwt_token', value: value);
  }

  signup(String name, String mail, String password, String phone) async {
    try {
      var res = await dio.post(ApiRoutes.signup, data: {
        'email': mail,
        'password': password,
        'phone': phone,
        'name': name,
      });
      if (res.statusCode == 200) {
        if (res.data['status'] != 'error') {
          setToken(res.data["data"]);
          Get.to(const SignupSuccessPage());
          // Get.toNamed(AppPagesRoutes.signupSuccess);
        } else {
          print(res.data['status']);
        }
        print(res.data);
        print(res.data["message"]);
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

  @override
  void onInit() {
    super.onInit();
    dio.options.baseUrl = baseUrl;

    name.addListener(getAllInputHasValue);
    mail.addListener(getAllInputHasValue);
    password.addListener(getAllInputHasValue);
    phone.addListener(getAllInputHasValue);

    getAllInputHasValue();
  }

  @override
  void onClose() {
    name.removeListener(getAllInputHasValue);
    mail.removeListener(getAllInputHasValue);
    password.removeListener(getAllInputHasValue);
    phone.removeListener(getAllInputHasValue);

    name.dispose();
    mail.dispose();
    password.dispose();
    phone.dispose();
    super.onClose();
  }
}
