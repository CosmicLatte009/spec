import 'package:get/get.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/page/signup_page.dart';
import 'package:spec/view/page/signup_success_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppPagesRoutes.signup, page: () => const SignupPage()),
    GetPage(
        name: AppPagesRoutes.signupSuccess,
        page: () => const SignupSuccessPage()),
  ];
}
