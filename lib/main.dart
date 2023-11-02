import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/Home_controller.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/catchup_controller.dart';
import 'package:spec/controller/changes_pw_controller.dart';
import 'package:spec/controller/login_controller.dart';

import 'package:spec/controller/my_page_controller.dart';
import 'package:spec/controller/profile_controller.dart';
import 'package:spec/controller/signup_controller.dart';
import 'package:spec/util/app_pages.dart';
import 'package:spec/view/page/home_page.dart';
import 'package:spec/view/page/auth/login_page.dart';
import 'package:spec/view/page/splash_page.dart';
import 'controller/talk/all_talk_controller.dart';
import 'controller/talk/detail_talk_controller.dart';
import 'controller/talk/hot_talk_controller.dart';

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
          Get.put(CatchUpController());
          Get.put(ChangePWController());
          Get.put(MyPageController());
          Get.put(HomeController());
          Get.lazyPut(() => ProfileController());
          Get.lazyPut(() => AllTalkController());
          Get.lazyPut(() => HotTalkController());
          Get.lazyPut(() => DetailTalkController());
        },
      ),
      getPages: AppPages.pages,
      // initialRoute: LoginPage.route,
      // home: const SplashPage(),
      home: SplashPage(),
    );
  }
}
