import 'package:spec/view/page/mogak/all_mogak_page.dart';
import 'package:spec/view/page/mogak/create_mogak_page.dart';
import 'package:spec/view/page/mogak/detail_mogak_page.dart';
import 'package:spec/view/page/mogak/hot_mogak_page.dart';
import 'package:spec/view/page/mogak/mogak_page.dart';
import 'package:spec/view/page/auth/signup_page.dart';
import 'package:spec/view/page/auth/signup_success_page.dart';

class AppPagesRoutes {
  static const String signup = SignupPage.route;
  static const String signupSuccess = SignupSuccessPage.route;
  static const String mogak = MogakPage.route;
  static const String hotMogak = HotMogakPage.route;
  static const String allMogak = AllMogakPage.route;
  static const String createMogak = CreateMogakPage.route;
  static const String detailMogak = DetailMogakPage.route;
}
