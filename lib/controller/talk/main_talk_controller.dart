import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/talk/talk.dart';
import 'talk_controller.dart';
import 'talk_editing_controller.dart';

class MainTalkController extends GetxController {
  final TalkController _talkController = Get.find<TalkController>();
  final TalkEditingController talkEditingController =
      Get.find<TalkEditingController>();

  final RxBool mainTalksLoading = true.obs;

  RxList<Talk> get allTalks => _talkController.allTalks;
  RxList<Talk> get hotTalks => _talkController.hotTalks;

  RxBool get allTalksLoading => _talkController.isAllTalksLoading;
  RxBool get hotTalksLoading => _talkController.isHotTalksLoading;

  getAllTalks() => _talkController.getAllTalks();
  getHotTalks() => _talkController.getHotTalks();

  _updateLoadingState() {
    mainTalksLoading.value = allTalksLoading.value || hotTalksLoading.value;
  }

  getMainTalks() async {
    mainTalksLoading.value = true;
    await Future.wait([
      _talkController.getAllTalks(),
      _talkController.getHotTalks(),
    ]).catchError((error) {
      return [];
    }).whenComplete(() {
      _updateLoadingState();
    });
  }

  TextEditingController textEditingController = TextEditingController();

  void postNewTalkInPopup() {
    TalkEditingController talkEditingController = Get.find();
    talkEditingController.postNewTalkInPopup(
      Get.context!,
      textEditingController,
    );
  }

  @override
  void onInit() async {
    super.onInit();
    getMainTalks();
    ever(allTalksLoading, (_) => _updateLoadingState());
    ever(hotTalksLoading, (_) => _updateLoadingState());
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
