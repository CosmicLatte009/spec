import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/me/avatar_controller.dart';
import 'package:spec/controller/signup_controller.dart';
import 'package:spec/model/my_profile.dart';
import 'package:spec/model/profile.dart';
import 'package:spec/view/page/me/my_page.dart';

class ProfileController extends GetxController {
  var controller = Get.find<SignupController>();
  var authController = Get.find<AuthController>();
  var avatarController = Get.find<AvatarController>();

  Dio dio = Dio();
  final List<String> _positions = ["DEVELOPER", "DESIGNER", "HEADHUNTER"];
  final RxInt _selectedIndex = RxInt(0);
  final RxBool _withAuth = false.obs;
  final RxString curAvatar = ''.obs;

  get selectedIndex => _selectedIndex.value;
  String get _selectedPosition {
    return _positions[_selectedIndex.value];
  }

  bool get withAuth => _withAuth.value;

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
          Get.to(const MyPage());
        } else {
          print(res.data['message']);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  uploadProfile() async {
    String path = '/api/me/profile';

    String nickname = nicknameController.text; //@todo 기존 닉네임 가져오기
    String bio = '수정된 프로필입니다.';
    String position = _selectedPosition;
    String? urlGithub = githubController.text;
    String? urlPortfolio = portfolio1Controller.text;
    String? urlEtc = portfolio2Controller.text;

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
        Get.to(const MyPage());
      } else {
        print(res.data);
      }
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
  }
}
