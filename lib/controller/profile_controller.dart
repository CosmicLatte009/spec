import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/me/avatar_controller.dart';
import 'package:spec/controller/signup_controller.dart';
import 'package:spec/model/profile.dart';
import 'package:spec/view/page/me/my_page.dart';
import 'package:spec/view/widget/alert/300_width_icon/icon_text_with_one_button.dart';

class ProfileController extends GetxController {
  var controller = Get.find<SignupController>();
  var authController = Get.find<AuthController>();
  var avatarController = Get.find<AvatarController>();

  Dio dio = Dio();
  final List<String> _positions = ["DEVELOPER", "DESIGNER", "HEADHUNTER"];
  final RxInt _selectedIndex = RxInt(0);
  final RxBool _withAuth = false.obs;

  get selectedIndex => _selectedIndex.value;
  String get _selectedPosition {
    return _positions[_selectedIndex.value];
  }

  bool get withAuth => _withAuth.value;
  Rxn<Profile> get curInfo => authController.myProfile;

  void updateIndex(int index) {
    _selectedIndex.value = index;
  }

  // required
  TextEditingController nicknameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  // optional
  TextEditingController linkedInController = TextEditingController();
  TextEditingController githubController = TextEditingController();
  TextEditingController portfolio1Controller = TextEditingController();
  TextEditingController portfolio2Controller = TextEditingController();
  String? get avatar => avatarController.imageUrl;

  createProfile() async {
    String path = '/api/me/profile';
    String nickname = nicknameController.text;
    // String bio = bioController.text;
    String bio = '자기소개란 입니다.';
    String position = _selectedPosition;
    String? urlGithub = githubController.text;
    String? urlPortfolio = portfolio1Controller.text;
    String? urlEtc = portfolio2Controller.text;

    try {
      var res = await dio.post(path, data: {
        'nickname': nickname,
        'bio': bio,
        'position': position,
        'avatar': avatar,
        'urlGithub': urlGithub,
        'urlPortfolio': urlPortfolio,
        'urlEtc': urlEtc,
      });
      if (res.statusCode == 200) {
        if (res.data['status'] == 'success') {
          String newToken = res.data["data"];
          controller.setToken(newToken); //토큰을 업데이트해야함.
          authController.getMyInfo();
          Get.to(const MyPage());
        } else {
          print(res.data['message']);
        }
      }
      print(withAuth);
      print(curInfo);
      print(dio.options.headers);
    } catch (e) {
      print(e);
    }
  }

  uploadProfile() async {
    String path = '/api/me/profile';

    String nickname = nicknameController.text;
    String bio = '수정된 프로필입니다.';
    String position = _selectedPosition;
    String? urlGithub = githubController.text;
    String? urlPortfolio = portfolio1Controller.text;
    String? urlEtc = portfolio2Controller.text;

    if (nickname != curInfo.value!.nickname) {
      Get.dialog(
        const IconTextWithOneButton(
          svgPath: 'assets/icons/svgs/Warning.svg',
          mainMessage: '닉네임을 수정할 수 없습니다.',
          subMessage: '다시 시도해주세요.',
          buttonTitle: '닫기',
        ),
      );
      nicknameController.text = curInfo.value!.nickname;
      return;
    }

    try {
      var res = await dio.put(path, data: {
        'nickname': nickname,
        'bio': bio,
        'position': position,
        'avatar': avatar,
        'urlGithub': urlGithub,
        'urlPortfolio': urlPortfolio,
        'urlEtc': urlEtc,
      });
      if (res.data['status'] == 'success') {
        authController.getMyInfo();
        Get.to(const MyPage());
      } else {
        print(res.data);
      }
      print(withAuth);
      print(curInfo);
    } catch (e) {
      print(e);
    }
  }

  getUserById(String userId) async {
    String path = '/api/profile/$userId';

    try {
      var res = await dio.get(path);
      if (res.data['data'] != null) {
        print(res.data["data"]);
        return Profile.fromMap(res.data["data"]);
      } else {
        print(res.data["message"]);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    String baseUrl = 'https://dev.sniperfactory.com';
    dio.options.baseUrl = baseUrl;
    RxString? authToken = RxString(await authController.getToken() ?? "");
    dio.options.headers['Authorization'] = authToken;

    if (authToken.value != "") {
      _withAuth.value = true;
    }

    ever(authController.myProfile, (callback) {
      if (curInfo.value != null && _withAuth.value == true) {
        nicknameController.text = curInfo.value!.nickname;
        int curIdx = _positions.indexOf(curInfo.value!.position);
        if (curIdx != -1) {
          updateIndex(curIdx);
        } else {
          updateIndex(0);
        }
      }
    });
  }
}
