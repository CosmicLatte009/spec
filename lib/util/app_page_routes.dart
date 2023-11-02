import 'package:spec/view/page/mogak/all_mogak_page.dart';
import 'package:spec/view/page/mogak/hot_mogak_page.dart';
import 'package:spec/view/page/mogak/mogak_page.dart';
import 'package:spec/view/page/signup_page.dart';
import 'package:spec/view/page/signup_success_page.dart';
import 'package:spec/view/page/talk/detail_talk_page.dart';
import 'package:spec/view/page/talk/hot_talk_page.dart';
import '../view/page/talk/all_talk_page.dart';
import '../view/page/talk/main_talk_page.dart';

class AppPagesRoutes {
  static const String signup = SignupPage.route;
  static const String signupSuccess = SignupSuccessPage.route;
  static const String mogak = MogakPage.route;
  static const String hotMogak = HotMogakPage.route;
  static const String allMogak = AllMogakPage.route;
  static const String mainTalk = MainTalkPage.route;
  static const String allTalk = AllTalkPage.route;
  static const String detailTalk = DetailTalkPage.route;
  static const String hotTalk = HotTalkPage.route;
}
