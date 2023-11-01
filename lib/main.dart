import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/login_controller.dart';
import 'package:spec/controller/mogak/all_mogak_controller.dart';
import 'package:spec/controller/mogak/create_mogak_controller.dart';
import 'package:spec/controller/mogak/hot_mogak_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/controller/profile_controller.dart';
import 'package:spec/controller/signup_controller.dart';
import 'package:spec/controller/talk/all_talks_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_pages.dart';
import 'package:spec/view/page/mogak/mogak_page.dart';
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
          Get.lazyPut(() => MogakController());
          Get.lazyPut(() => AllMogakController());
          Get.lazyPut(() => HotMogakController());
          Get.lazyPut(() => CreateMogakController());
          Get.lazyPut(() => ProfileController());
          Get.lazyPut(() => AllTalksController());
        },
      ),
      getPages: AppPages.pages,
      // initialRoute: LoginPage.route,
      // home: const SplashPage(),
      home: const MogakPage(),
    );
  }
}
