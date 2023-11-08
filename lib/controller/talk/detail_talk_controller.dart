import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/util/api_routes.dart';
import '../../model/talk.dart';
import 'talk_controller.dart';
import 'talk_editing_controller.dart';

class DetailTalkController extends GetxController {
  final TalkController _talkController = Get.find<TalkController>();
  final TalkEditingController talkEditingController =
      Get.find<TalkEditingController>();

  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  final String talkId;
  DetailTalkController(this.talkId);

  final Rxn<Talk> _detailTalk = Rxn();
  final RxList<Talk> _commentTalk = <Talk>[].obs;

  Rxn<Talk> get detailTalk => _detailTalk;
  RxList<Talk> get commentTalk => _commentTalk;

  RxBool isLoading = true.obs;

  getTalkById() async {
    try {
      isLoading.value = true;
      String path = '${ApiRoutes.talk}/$talkId';
      var res = await dio.get(path);
      var resData = res.data["data"];
      _detailTalk.value = Talk.fromMap(resData["talk"]);

      var commentData = List<Map<String, dynamic>>.from(resData["children"]);
      var commentList = commentData.map((map) => Talk.fromMap(map)).toList();
      _commentTalk.assignAll(commentList);

      isLoading.value = false;
      print(detailTalk);
      // print(commentTalk);
    } on DioException catch (e) {
      isLoading.value = true;
      print('단일 톡 불러오기 실패야');
      print(e.toString());
    }
  }

  getAllTalks() => _talkController.getAllTalks();
  getHotTalks() => _talkController.getHotTalks();

  final TextEditingController textEditingController = TextEditingController();

  void postNewTalkComment() {
    talkEditingController.postNewTalkComment(
      textEditingController.text,
      null, // mogakId
      null, // catchUpId
      talkId,
      textEditingController,
      afterPostSuccess: () {
        getTalkById();
        getAllTalks();
        getHotTalks();
      },
    );
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;

    if (talkId.isNotEmpty) {
      getTalkById();
    }

    print('단일톡 onInit은 되니');
  }
}
