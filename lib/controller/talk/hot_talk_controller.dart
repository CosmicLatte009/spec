import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/talk.dart';
import 'talk_controller.dart';
import 'talk_editing_controller.dart';

class HotTalkController extends GetxController {
  final TalkController _talkController = Get.find<TalkController>();
  final TalkEditingController talkEditingController =
      Get.find<TalkEditingController>();

  RxList<Talk> get hotTalks => _talkController.hotTalks;
  RxBool get hotTalksLoading => _talkController.isHotTalksLoading;

  getHotTalks() => _talkController.getHotTalks();

  TextEditingController textEditingController = TextEditingController();
  void postNewTalkInPopup() {
    talkEditingController.postNewTalkInPopup(
        Get.context!, textEditingController,
        afterPostSuccess: getHotTalks);
  }

  @override
  void onInit() async {
    super.onInit();
    await getHotTalks();
  }
}
