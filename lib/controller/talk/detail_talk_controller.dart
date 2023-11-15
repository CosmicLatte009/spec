import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  Talk? get detailTalk => _talkController.detailTalk.value;
  List<Talk> get commentTalks => _talkController.commentTalks;

  bool get isDetailLoading => _talkController.isDetailTalkLoading.value;

  getAllTalks() => _talkController.getAllTalks();
  getHotTalks() => _talkController.getHotTalks();

  final TextEditingController textEditingController = TextEditingController();

  getTalkById() async {
    try {
      _talkController.isDetailTalkLoading.value = true;
      await _talkController.getTalkById(talkId);

      _talkController.isDetailTalkLoading.value = false;

      update();
    } catch (e) {
      _talkController.isDetailTalkLoading.value = false;
    }
  }

  void postNewTalkComment() {
    talkEditingController.postNewTalkComment(
      textEditingController.text,
      null, // mogakId
      null, // catchUpId
      talkId, // parentId
      textEditingController,
      afterPostSuccess: () async {
        await getTalkById();
        _talkController.update();
      },
    );
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;

    if (talkId.isNotEmpty) {
      _talkController.getTalkById(talkId);
    }
  }

  @override
  void onClose() async {
    textEditingController.dispose();
    super.onClose();
  }
}
