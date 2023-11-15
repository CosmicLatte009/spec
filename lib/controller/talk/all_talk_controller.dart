import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/talk.dart';
import 'talk_controller.dart';
import 'talk_editing_controller.dart';

class AllTalkController extends GetxController {
  final TalkController _talkController = Get.find<TalkController>();
  final TalkEditingController talkEditingController =
      Get.find<TalkEditingController>();

  RxList<Talk> get allTalks => _talkController.allTalks;
  RxBool get allTalksLoading => _talkController.isAllTalksLoading;

  getAllTalks() => _talkController.getAllTalks();

  TextEditingController textEditingController = TextEditingController();
  void postNewTalkInPopup() {
    talkEditingController.postNewTalkInPopup(
      Get.context!,
      textEditingController,
    );
  }

  @override
  void onInit() async {
    super.onInit();
    await getAllTalks();
  }
}
