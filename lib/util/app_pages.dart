import 'package:get/get.dart';
import 'package:spec/controller/filter_controller.dart';
import 'package:spec/controller/mogak/all_mogak_controller.dart';
import 'package:spec/controller/mogak/create_mogak_controller.dart';
import 'package:spec/controller/mogak/detail_mogak_controller.dart';
import 'package:spec/controller/mogak/hot_mogak_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/controller/content_search_controller.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/page/auth/forgot_password_page.dart';
import 'package:spec/view/page/catchup/Hot_catch_up_page.dart';
import 'package:spec/view/page/catchup/catch_up_page.dart';
import 'package:spec/view/page/auth/login_page.dart';
import 'package:spec/view/page/me/my_page.dart';
import 'package:spec/view/page/mogak/all_mogak_page.dart';
import 'package:spec/view/page/mogak/create_mogak_page.dart';
import 'package:spec/view/page/mogak/detail_mogak_page.dart';
import 'package:spec/view/page/mogak/hot_mogak_page.dart';
import 'package:spec/view/page/mogak/mogak_page.dart';
import 'package:spec/view/page/auth/signup_page.dart';
import 'package:spec/view/page/auth/signup_success_page.dart';
import '../controller/talk/detail_talk_controller.dart';
import '../view/page/home_page.dart';
import '../view/page/talk/all_talk_page.dart';
import '../view/page/talk/detail_talk_page.dart';
import '../view/page/talk/hot_talk_page.dart';
import '../view/page/talk/main_talk_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppPagesRoutes.signup,
      page: () => const SignupPage(),
    ),
    GetPage(
        name: AppPagesRoutes.signupSuccess,
        page: () => const SignupSuccessPage()),
    GetPage(
        name: AppPagesRoutes.mogak,
        page: () => const MogakPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => MogakController());
          Get.lazyPut(() => FilterController());
          Get.lazyPut(() => ContentSearchController());
        })),
    GetPage(
      name: AppPagesRoutes.allMogak,
      page: () => const AllMogakPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AllMogakController());
        Get.lazyPut(() => FilterController());
        Get.lazyPut(() => ContentSearchController());
      }),
    ),
    GetPage(
      name: AppPagesRoutes.hotMogak,
      page: () => const HotMogakPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HotMogakController());
        Get.lazyPut(() => FilterController());
        Get.lazyPut(() => ContentSearchController());
      }),
    ),
    GetPage(
      name: AppPagesRoutes.createMogak,
      page: () => const CreateMogakPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CreateMogakController());
      }),
    ),
    GetPage(
      name: '/mogak/:id',
      page: () => const DetailMogakPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DetailMogakController(Get.parameters['id']!));
      }),
    ),
    GetPage(
      name: AppPagesRoutes.catchUp,
      page: () => CatchUpPage(),
    ),
    GetPage(
      name: AppPagesRoutes.hotCatchUp,
      page: () => HotCatchUp(),
    ),
    GetPage(
      name: AppPagesRoutes.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: AppPagesRoutes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppPagesRoutes.forgotPw,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(
      name: AppPagesRoutes.mainTalk,
      page: () => const MainTalkPage(),
    ),
    GetPage(
      name: AppPagesRoutes.allTalk,
      page: () => const AllTalkPage(),
    ),
    GetPage(
      name: AppPagesRoutes.detailTalk,
      page: () => const DetailTalkPage(),
      binding: BindingsBuilder(() {
        String? id = Get.parameters['id'];
        print('Binding for DetailTalkController with id: $id');
        if (id != null) {
          Get.put(DetailTalkController(id));
        } else {
          print('Error: Talk ID is null');
        }
      }),
    ),
    GetPage(
      name: AppPagesRoutes.hotTalk,
      page: () => const HotTalkPage(),
    ),
    GetPage(
      name: AppPagesRoutes.myPage,
      page: () => MyPage(),
    ),
  ];
}
