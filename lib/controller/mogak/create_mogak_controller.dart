import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';

class CreateMogakController extends GetxController {
  var authController = Get.find<AuthController>();

  Dio dio = Dio();
  List<String> visiblityStatus = ["HIDDEN", "OPEN", "CLOSE"];
  final RxInt _selectedIndex = RxInt(0);

  TextEditingController titleController = TextEditingController();
  TextEditingController contentsController = TextEditingController();
  TextEditingController maxNumberController = TextEditingController();
  TextEditingController tagController = TextEditingController();

  get selectedIndex => _selectedIndex.value;
  get _visiblityState {
    return visiblityStatus[_selectedIndex.value];
  }

  void updateIndex(int index) {
    _selectedIndex.value = index;
  }

  submitAction() async {
    String path = '/api/mogak';

    String content = titleController.text; //5자 이상, 50자 이하
    String title = contentsController.text; // 10자 이상, 500자 이하
    int maxMember = int.parse(maxNumberController.text); // 1명 이상 100명 이하
    String hashtag = tagController.text; // 디폴트: 빈 문자열
    String visiblityState = _visiblityState; // 값 입력하지 않았을 경우 OPEN으로 default

    try {
      var res = await dio.post(path, data: {
        'content': content,
        'title': title,
        'maxMember': maxMember,
        'hashtag': hashtag,
        'visiblityStatus': visiblityState,
      });

      print(res.data);
      if (res.statusCode == 200) {
        if (res.data["status"]) {
          //@todo submitAction이 발생하면 어디로 리다이렉트 할 것인가?
          print(res.data["data"]);
        } else {
          print(res.data["message"]);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  updateMogak({required String mogakId}) async {
    String path = "/api/mogak/$mogakId";

    String content = titleController.text; //5자 이상, 50자 이하
    String title = contentsController.text; // 10자 이상, 500자 이하
    int maxMember = int.parse(maxNumberController.text); // 1명 이상 100명 이하
    String hashtag = tagController.text; // 디폴트: 빈 문자열
    String visiblityState = _visiblityState; // 값 입력하지 않았을 경우 OPEN으로 default

    try {
      var res = await dio.put(path, data: {
        'content': content,
        'title': title,
        'maxMember': maxMember,
        'hashtag': hashtag,
        'visiblityStatus': visiblityState,
      });

      print(res.data);
      if (res.statusCode == 200) {
        if (res.data["status"]) {
          //@todo submitAction이 발생하면 어디로 리다이렉트 할 것인가?
          print(res.data["data"]);
        } else {
          print(res.data["message"]);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = 'https://dev.sniperfactory.com';
    String? authToken = await authController.getToken();

    if (authToken != null) {
      dio.options.headers['Authorization'] = authToken;
      print(authToken);
    }
  }
}
