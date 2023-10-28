import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/login_controller.dart';
import 'package:spec/controller/signup_controller.dart';
import 'package:spec/view/page/signup_page.dart';
import 'package:spec/view/page/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(
        () {
          Get.put(AuthController());
          Get.put(LoginController());
          Get.lazyPut(() => SignupController());
        },
      ),
      // getPages: AppPages.pages,
      // initialRoute: LoginPage.route,
      // home: const SplashPage(),
      home: const SignupPage(),
    );
  }
}
