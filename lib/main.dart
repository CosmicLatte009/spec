import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/Home_controller.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/best_spacer_controller.dart';
import 'package:spec/controller/content_search_controller.dart';
import 'package:spec/controller/filter_controller.dart';
import 'package:spec/controller/forgot_pw_controller.dart';
import 'package:spec/controller/like_controller.dart';
import 'package:spec/controller/catchup_controller.dart';
import 'package:spec/controller/changes_pw_controller.dart';
import 'package:spec/controller/login_controller.dart';
import 'package:spec/controller/mogak/hot_mogak_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/controller/my_page_controller.dart';
import 'package:spec/controller/profile_controller.dart';
import 'package:spec/controller/signup_controller.dart';
import 'package:spec/controller/talk/main_talk_controller.dart';
import 'package:spec/controller/talk/talk_editing_controller.dart';
import 'package:spec/util/app_pages.dart';
import 'controller/talk/all_talk_controller.dart';
import 'controller/talk/hot_talk_controller.dart';
import 'controller/talk/talk_controller.dart';
import 'view/page/auth/login_page.dart';
import 'view/page/splash_page.dart';

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
          Get.lazyPut(() => ForgotPasswordController());
          Get.put(CatchUpController());
          Get.put(ChangePWController());
          Get.put(MyPageController());
          Get.put(HomeController());
          Get.lazyPut(() => HotMogakController());
          Get.lazyPut(() => MogakController());
          Get.lazyPut(() => ProfileController());
          Get.lazyPut(() => LikeController());
          Get.put(TalkController());
          Get.put(TalkEditingController());
          Get.put(MainTalkController());
          Get.put(AllTalkController());
          Get.put(HotTalkController());
          Get.put(FilterController());
          Get.put(ContentSearchController());
          Get.lazyPut(() => MyPageController());
          Get.lazyPut(() => MainTalkController());
          Get.lazyPut(() => BestSpacerController());
          Get.lazyPut(() => FilterController());
          Get.lazyPut(() => ContentSearchController());
        },
      ),
      getPages: AppPages.pages,
      //  initialRoute: LoginPage.route,
      // home: const SplashPage(),
      home: SplashPage(),
    );
  }
}
