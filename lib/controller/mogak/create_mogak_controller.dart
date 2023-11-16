import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/widget/alert/300_width/with_one_button.dart';
import 'package:spec/view/widget/alert/360_width_avatar/avatar_with_one_button.dart';

class CreateMogakController extends GetxController {
  var controller = Get.find<MogakController>();
  var authController = Get.find<AuthController>();

  Dio dio = Dio();
  List<String> visiblityStatus = ["HIDDEN", "OPEN", "CLOSE"];
  final RxInt _selectedIndex = RxInt(-1);
  var maxMemberAsString = ''.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentsController = TextEditingController();
  TextEditingController maxNumberController = TextEditingController();
  TextEditingController tagController = TextEditingController();

  RxInt get selectedIndex => _selectedIndex;
  get _visiblityState {
    return visiblityStatus[_selectedIndex.value];
  }

  int get maxMember => int.tryParse(maxMemberAsString.value) ?? 0;

  void updateIndex(int index) {
    _selectedIndex.value = index;
  }

  /// validation - title, content
  stringLengthValidation({required String text, int? min, int? max}) {
    min = min ?? 5;
    max = max ?? 50;

    if (text.length < min || text.length > 50) {
      return "글자 수는 $min 이상, $max 이상이어야 합니다.";
    }
    return;
  }

  /// validation - maxMember
  minMaxValidation({required int num, int? min, int? max}) {
    min = min ?? 1;
    max = max ?? 100;

    if (num < min || num > max) {
      return "모임은 $min명이상 $max명 이하여야 합니다.";
    }
    return;
  }

  submitAction() async {
    String path = '/api/mogak';
    String title = titleController.text; //5자 이상, 50자 이하
    String content = contentsController.text; // 10자 이상, 500자 이하
    int maxMember = int.parse(maxNumberController.text); // 1명 이상 100명 이하
    String hashtag = tagController.text; // 디폴트: 빈 문자열
    String visiblityState =
        _visiblityState ?? "OPEN"; // 값 입력하지 않았을 경우 OPEN으로 default

    try {
      var res = await dio.post(path, data: {
        'title': title,
        'content': content,
        'maxMember': maxMember,
        'hashtag': hashtag,
        'visiblityStatus': visiblityState,
      });

      if (res.statusCode == 200) {
        if (res.data["status"] == 'success') {
          await Get.dialog(
            const AvatarWithOneButton(
              mainMessage: '모각코 모집 글이 성공적으로 작성되었습니다.',
            ),
          );
          controller.getAllMogak();
          Get.toNamed(AppPagesRoutes.allMogak);
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

    String title = titleController.text; //5자 이상, 50자 이하
    String content = contentsController.text; // 10자 이상, 500자 이하
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

      if (res.statusCode == 200) {
        if (res.data["status"] == 'success') {
          await Get.dialog(
            const AvatarWithOneButton(
              mainMessage: '모각코 모집 글이 성공적으로 수정되었습니다.',
            ),
          );
          controller.getAllMogak();
          Get.toNamed(AppPagesRoutes.allMogak);
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
    }

    maxNumberController.addListener(() {
      maxMemberAsString.value = maxNumberController.text;
    });
  }
}
