import 'package:spec/view/page/auth/forgot_password_page.dart';
import 'package:spec/view/page/catchup/Hot_catch_up_page.dart';
import 'package:spec/view/page/catchup/catch_up_page.dart';
import 'package:spec/view/page/home_page.dart';
import 'package:spec/view/page/auth/login_page.dart';
import 'package:spec/view/page/me/my_page.dart';
import 'package:spec/view/page/me/profile_edit_page.dart';
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
import '../view/page/talk/all_talk_page.dart';
import '../view/page/talk/detail_talk_page.dart';
import '../view/page/talk/hot_talk_page.dart';
import '../view/page/talk/main_talk_page.dart';

class AppPagesRoutes {
  static const String home = HomePage.route;
  static const String login = LoginScreen.route;
  static const String signup = SignupPage.route;
  static const String signupSuccess = SignupSuccessPage.route;
  static const String forgotPw = ForgotPasswordPage.route;
  static const String profileEdit = ProfileEditPage.route;

  /// 모각
  static const String mogak = MogakPage.route;
  static const String hotMogak = HotMogakPage.route;
  static const String allMogak = AllMogakPage.route;
  static const String createMogak = CreateMogakPage.route;
  static const String meMogak = MeMogakPage.route;
  static const String joinedMogak = JoinedMogakPage.route;
  static const String detailMogak = DetailMogakPage.route;
  static const String updateMogak = UpdateMogakPage.route;

  /// 캐치업
  static const String catchUp = CatchUpPage.route;
  static const String hotCatchUp = HotCatchUp.route;

  /// 톡
  static const String mainTalk = MainTalkPage.route;
  static const String allTalk = AllTalkPage.route;
  static const String detailTalk = DetailTalkPage.route;
  static const String hotTalk = HotTalkPage.route;
  static const String myPage = MyPage.route;
}
