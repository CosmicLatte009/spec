import 'package:get/get.dart';
import 'package:spec/controller/filter_controller.dart';
import 'package:spec/controller/like_controller.dart';
import 'package:spec/controller/mogak/all_mogak_controller.dart';
import 'package:spec/controller/mogak/create_mogak_controller.dart';
import 'package:spec/controller/mogak/detail_mogak_controller.dart';
import 'package:spec/controller/mogak/hot_mogak_controller.dart';
import 'package:spec/controller/mogak/me/joined_mogak_controller.dart';
import 'package:spec/controller/mogak/me/me_mogak_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/controller/content_search_controller.dart';
import 'package:spec/controller/mogak/update_mogak_controller.dart';
import 'package:spec/controller/profile_controller.dart';
import 'package:spec/controller/signup_controller.dart';
import 'package:spec/controller/talk/main_talk_controller.dart';
import 'package:spec/controller/talk/me/my_comment_talk_controller.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/page/auth/change_password_page.dart';
import 'package:spec/view/page/auth/forgot_password_page.dart';
import 'package:spec/view/page/catchup/Hot_catch_up_page.dart';
import 'package:spec/view/page/catchup/catch_up_page.dart';
import 'package:spec/view/page/auth/login_page.dart';
import 'package:spec/view/page/me/my_page.dart';
import 'package:spec/view/page/mogak/all_mogak_page.dart';
import 'package:spec/view/page/mogak/create_mogak_page.dart';
import 'package:spec/view/page/mogak/detail_mogak_page.dart';
import 'package:spec/view/page/mogak/hot_mogak_page.dart';
import 'package:spec/view/page/mogak/me/joined_mogak_page.dart';
import 'package:spec/view/page/mogak/me/me_mogak_page.dart';
import 'package:spec/view/page/mogak/mogak_page.dart';
import 'package:spec/view/page/auth/signup_page.dart';
import 'package:spec/view/page/auth/signup_success_page.dart';
import 'package:spec/view/page/mogak/update_mogak_page.dart';
import '../controller/talk/detail_talk_controller.dart';
import '../controller/talk/me/my_talk_controller.dart';
import '../controller/talk/me/my_up_talk_controller.dart';
import '../view/page/home_page.dart';
import '../view/page/talk/all_talk_page.dart';
import '../view/page/talk/detail_talk_page.dart';
import '../view/page/talk/hot_talk_page.dart';
import '../view/page/talk/main_talk_page.dart';
import '../view/page/talk/me/my_comment_talk_page.dart';
import '../view/page/talk/me/my_talk_page.dart';
import '../view/page/talk/me/my_up_talk_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppPagesRoutes.home,
      page: () => const HomePage(),
    ),
    //auth
    GetPage(
      name: AppPagesRoutes.signup,
      page: () => const SignupPage(),
    ),
    GetPage(
        name: AppPagesRoutes.signupSuccess,
        page: () => const SignupSuccessPage()),
    GetPage(
      name: AppPagesRoutes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppPagesRoutes.forgotPw,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(
      name: AppPagesRoutes.changePw,
      page: () => const ChangePasswordPage(),
    ),
    //talk
    GetPage(
      name: AppPagesRoutes.mainTalk,
      page: () => const MainTalkPage(),
      binding: BindingsBuilder(() {
        //   Get.put(MainTalkController());
      }),
    ),
    GetPage(
      name: AppPagesRoutes.allTalk,
      page: () => const AllTalkPage(),
    ),
    GetPage(
      name: AppPagesRoutes.hotTalk,
      page: () => const HotTalkPage(),
    ),
    //catchup
    GetPage(
      name: AppPagesRoutes.catchUp,
      page: () => CatchUpPage(),
    ),
    GetPage(
      name: AppPagesRoutes.hotCatchUp,
      page: () => HotCatchUp(),
    ),
    //mogak
    GetPage(
        name: AppPagesRoutes.mogak,
        page: () => const MogakPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => MogakController());
          Get.lazyPut(() => FilterController());
          Get.lazyPut(() => ContentSearchController());
          Get.lazyPut(() => CreateMogakController());
          Get.lazyPut(() => LikeController());
          Get.lazyPut(() => SignupController()); // @todo 어디까지 바인딩해야하는가?
        })),
    GetPage(
      name: AppPagesRoutes.allMogak,
      page: () => const AllMogakPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AllMogakController());
        Get.lazyPut(() => FilterController());
        Get.lazyPut(() => ContentSearchController());
        Get.lazyPut(() => CreateMogakController());
        Get.lazyPut(() => LikeController());
      }),
    ),
    GetPage(
      name: AppPagesRoutes.hotMogak,
      page: () => const HotMogakPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HotMogakController());
        Get.lazyPut(() => FilterController());
        Get.lazyPut(() => ContentSearchController());
        Get.lazyPut(() => CreateMogakController());
        Get.lazyPut(() => LikeController());
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
      name: AppPagesRoutes.meMogak,
      page: () => const MeMogakPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MeMogakController());
        Get.lazyPut(() => LikeController());
        Get.lazyPut(() => CreateMogakController());
      }),
    ),
    GetPage(
      name: AppPagesRoutes.joinedMogak,
      page: () => const JoinedMogakPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => JoinedMogakController());
        Get.lazyPut(() => LikeController());
      }),
    ),
    GetPage(
      name: '/mogak/update/:id',
      page: () => const UpdateMogakPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => UpdateMogakController(Get.parameters['id']!));
        Get.lazyPut(() => CreateMogakController());
        Get.lazyPut(() => DetailMogakController(Get.parameters['id']!));
        Get.lazyPut(() => JoinedMogakController());
        Get.lazyPut(() => ProfileController());
      }),
    ),
    GetPage(
      name: '/mogak/:id',
      page: () => const DetailMogakPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DetailMogakController(Get.parameters['id']!));
        Get.lazyPut(() => JoinedMogakController());
        Get.lazyPut(() => LikeController());
        Get.lazyPut(() => ProfileController());
        Get.lazyPut(() => SignupController()); // @todo 어디까지 바인딩해야하는가?
      }),
    ),
    GetPage(
      name: AppPagesRoutes.detailTalk,
      page: () => const DetailTalkPage(),
      binding: BindingsBuilder(() {
        String? id = Get.parameters['id'];
        if (id != null) {
          Get.put(DetailTalkController(id));
        }
      }),
    ),
    GetPage(
      name: AppPagesRoutes.myPage,
      page: () => MyPage(),
    ),
    GetPage(
      name: AppPagesRoutes.myTalk,
      page: () => const MyTalkPage(),
      binding: BindingsBuilder(() {
        Get.put(MyTalkController());
      }),
    ),
    GetPage(
      name: AppPagesRoutes.myUpTalk,
      page: () => const MyUpTalkPage(),
      binding: BindingsBuilder(() {
        Get.put(MyUpTalkController());
      }),
    ),
    GetPage(
      name: AppPagesRoutes.myCommentTalk,
      page: () => const MyCommentTalkPage(),
      binding: BindingsBuilder(() {
        Get.put(MyCommentTalkController());
      }),
    ),
  ];
}
