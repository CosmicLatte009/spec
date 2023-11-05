import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/util/api_routes.dart';

class TalkEditingController extends GetxController {
  RxString talkId = ''.obs;
  void setTalkId(String newTalkId) {
    talkId.value = newTalkId;
  }

  RxBool hasValue = false.obs;
  final TextEditingController contentController = TextEditingController();

  final Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  postNewTalk(
    String content,
    String? mogakId,
    String? catchUpId,
    String? parentId,
  ) async {
    final Map<String, dynamic> requestData = {
      "content": content,
    };
    if (mogakId != null) requestData['mogakId'] = mogakId;
    if (catchUpId != null) requestData['catchUpId'] = catchUpId;
    if (parentId != null) requestData['parentId'] = parentId;

    try {
      var res = await dio.post(ApiRoutes.talk, data: {
        requestData,
      });
      if (res.statusCode == 200 && res.data["status"] == "success") {
        print(res);
      }
    } on DioException catch (e) {
      print('새로운 톡 생성하기 실패여');
      print(e.message);
    }
  }

  putTalkById(
    String content,
  ) async {
    if (talkId.isBlank!) {
      print('톡 ID가 설정되지 않았습니다.');
      return;
    }
    try {
      String path = '${ApiRoutes.talk}/${talkId.value}';
      var res = await dio.put(path, data: {
        'content': content,
      });
      if (res.statusCode == 200 && res.data["status"] == "success") {
        print(res);
      }
    } on DioException catch (e) {
      print('톡 수정하기 실패여');
      print(e.message);
    }
  }

  deleteTalkById() async {
    try {
      String path = '${ApiRoutes.talk}/${talkId.value}';
      var res = await dio.delete(path);
      if (res.statusCode == 200 && res.data["status"] == "success") {
        print(res);
      }
    } on DioException catch (e) {
      print('톡 삭제하기 실패여');
      print(e.message);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;
    print('TextEditingController onInit은 되니');
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
}
