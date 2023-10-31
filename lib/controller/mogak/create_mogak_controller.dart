import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateMogakController extends GetxController {
  Dio dio = Dio();
  String path = '/api/mogak';

  TextEditingController titleController = TextEditingController();
  TextEditingController contentsController = TextEditingController();
  TextEditingController partyNumController = TextEditingController();
  TextEditingController tagController = TextEditingController();

  submitAction() async {
    String content = titleController.text;
    String title = contentsController.text;
    int maxMember = partyNumController.text as int;
    String tag = tagController.text;
    try {
      var res = await dio.post(path, data: {
        content: content,
        title: title,
        maxMember: maxMember,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    dio.options.baseUrl = 'https://dev.sniperfactory.com';
    //@todo submitAction이 발생하면 어디로 리다이렉트 할 것인가?
  }
}
