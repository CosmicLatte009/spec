import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/signup_controller.dart';

class ProfileController extends GetxController {
  var controller = Get.find<SignupController>();
  var authController = Get.find<AuthController>();

  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';
  final List<String> _positions = ["DEVELOPER", "DESIGNER", "HEADHUNTER"];
  final RxInt _selectedIndex = RxInt(0);

  get selectedIndex => _selectedIndex.value;
  String get _selectedPosition {
    return _positions[_selectedIndex.value];
  }

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

  String? avatar;

  createProfile() async {
    String path = '/api/me/profile';
    String nickname = nicknameController.text;
    // String bio = bioController.text ?? "이건뭐야";
    String bio = "이건뭐야";
    String position = _selectedPosition;
    // String? urlGithub = githubController.text;
    // String? urlPortfolio = portfolio1Controller.text;
    // String? urlEtc = portfolio2Controller.text;

    try {
      var res = await dio.post(path, data: {
        nickname,
        bio,
        position,
        avatar,
        // urlGithub,
        // urlPortfolio,
        // urlEtc,
      });
      print(res.data);
      if (res.statusCode == 200) {
        if (res.data['status'] == 'sucsess') {
          controller.setToken(res.data["data"]);
          print('성공');
        } else {
          print('실패');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //@todo 추후 정리
  getAuth() async {
    try {
      var res = await authController.getToken();
      print(res);
      return res;
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;
    String? authToken = await getAuth();
    dio.options.headers['Authorization'] = authToken;

    print(authToken);
  }
}
