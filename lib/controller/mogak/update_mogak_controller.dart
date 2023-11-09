import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/create_mogak_controller.dart';
import 'package:spec/controller/mogak/detail_mogak_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/model/detail_mogak.dart';

class UpdateMogakController extends GetxController {
  var controller = Get.find<MogakController>();
  var detailController = Get.find<DetailMogakController>();
  var createController = Get.find<CreateMogakController>();

  TextEditingController get titleController => createController.titleController;
  TextEditingController get contentsController =>
      createController.contentsController;
  TextEditingController get tagsController => createController.tagController;
  TextEditingController get maxNumberController =>
      createController.maxNumberController;
  RxInt get selectedIndex => createController.selectedIndex;

  var maxMemberAsString = ''.obs;
  int get maxMember => int.tryParse(maxMemberAsString.value) ?? 0;

  Rxn<DetailMogak> get detailMogak => detailController.detailMogak;
  List<String> get visibilityStatus => createController.visiblityStatus;

  validation() {
    var titleValid =
        createController.stringLengthValidation(text: titleController.text);
    var contentValid = createController.stringLengthValidation(
        text: contentsController.text, min: 10, max: 500);
    var maxMemberValid = createController.minMaxValidation(num: maxMember);

    if (titleValid == null && contentValid == null && maxMemberValid == null) {
      return true;
    }
    return false;
  }

  updateMogak() async {
    await createController.updateMogak(mogakId: mogakId.value);
    print('수정요청');
  }

  RxString mogakId = RxString('');
  // * 동적으로 route를 생성하기 위해 생성자 필요.
  UpdateMogakController(String id) {
    mogakId.value = id;
  }

  @override
  void onInit() async {
    super.onInit();
    await detailController.getDetailMogak();

    maxNumberController.addListener(() {
      maxMemberAsString.value = maxNumberController.text;
    });

    if (detailMogak.value != null) {
      titleController.text = detailMogak.value!.title;
      contentsController.text = detailMogak.value!.content;
      tagsController.text = detailMogak.value!.hashtag ?? '';
      maxNumberController.text = detailMogak.value!.maxMember.toString();

      maxMemberAsString.value = maxNumberController.text;

      maxNumberController.addListener(() {
        maxMemberAsString.value = maxNumberController.text;
      });

      int index = visibilityStatus.indexOf(detailMogak.value!.visiblityStatus);
      if (index != -1) {
        selectedIndex.value = index;
      } else {
        selectedIndex.value = 0;
      }
    }
  }
}
