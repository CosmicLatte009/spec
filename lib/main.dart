import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/Home_controller.dart';
import 'package:spec/controller/auth/auth_controller.dart';
import 'package:spec/controller/etc/best_spacer_controller.dart';
import 'package:spec/controller/etc/content_search_controller.dart';
import 'package:spec/controller/etc/upload_controller.dart';
import 'package:spec/controller/etc/filter_controller.dart';
import 'package:spec/controller/auth/forgot_pw_controller.dart';
import 'package:spec/controller/etc/like_controller.dart';
import 'package:spec/controller/catchup/catchup_controller.dart';
import 'package:spec/controller/auth/changes_pw_controller.dart';
import 'package:spec/controller/auth/login_controller.dart';
import 'package:spec/controller/me/avatar_controller.dart';
import 'package:spec/controller/mogak/hot_mogak_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/controller/me/my_page_controller.dart';
import 'package:spec/controller/me/profile_controller.dart';
import 'package:spec/controller/auth/signup_controller.dart';
import 'package:spec/controller/talk/main_talk_controller.dart';
import 'package:spec/controller/talk/talk_editing_controller.dart';
import 'package:spec/util/app_pages.dart';
import 'package:spec/view/page/best_spacer/best_spacer_page.dart';
import 'package:spec/view/page/home_page.dart';
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
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(
        () {
          Get.put(AuthController());
          Get.put(LoginController());
          Get.lazyPut(() => SignupController());
          Get.put(ForgotPasswordController());
          Get.lazyPut(() => ProfileController());
          Get.lazyPut(() => AvatarController());
          Get.lazyPut(() => UploadController());
          Get.put(CatchUpController());
          Get.put(ChangePWController());
          Get.put(MyPageController());
          Get.put(HomeController());
          Get.lazyPut(() => HotMogakController());
          Get.lazyPut(() => MogakController());
          Get.lazyPut(() => LikeController());
          Get.put(TalkController());
          Get.put(TalkEditingController());
          Get.put(MainTalkController());
          Get.put(AllTalkController());
          Get.put(HotTalkController());
          Get.put(FilterController());
          Get.put(ContentSearchController());
          Get.lazyPut(() => BestSpacerController());
        },
      ),
      getPages: AppPages.pages,
      //  initialRoute: LoginPage.route,
      // home: const SplashPage(),
      // home: SplashPage(),
      // home: const HomePage(),
      home: LoginScreen(),
    );
  }
}
