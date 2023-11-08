import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/talk.dart';
import '../../view/widget/alert/300_width_description/description_with_two_button.dart';
import '../../view/widget/popup/talk_editing_popup.dart';
import 'talk_controller.dart';

class TalkEditingController extends GetxController {
  final _talkController = Get.find<TalkController>();

  // RxString talkId = ''.obs;
  // void setTalkId(String newTalkId) {
  //   talkId.value = newTalkId;
  // }

  getCurrentTalk(String id) {
    final talk =
        _talkController.allTalks.firstWhereOrNull((talk) => talk.id == id);
    final hotTalk =
        _talkController.hotTalks.firstWhereOrNull((talk) => talk.id == id);

    return talk ?? hotTalk;
  }

  //팝업창에서 POST
  Future<void> postNewTalkInPopup(
      BuildContext context, TextEditingController textEditingController,
      {required VoidCallback afterPostSuccess}) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return TalkEditingPopup(
          controller: textEditingController,
          onSubmit: () async {
            String content = textEditingController.text;
            if (content.trim().isEmpty) {
              Get.snackbar('Error', '톡 내용을 작성해주세요!');
              return;
            }
            bool success = await _talkController.postNewTalk(
              content,
              null,
              null,
              null,
            );
            if (success) {
              Navigator.of(context).pop();
              textEditingController.clear();
              Get.snackbar('Success', '톡이 성공적으로 생성되었습니다.');
              afterPostSuccess();
            } else {
              Get.snackbar('Error', '톡 생성에 실패했습니다.');
            }
          },
        );
      },
    );
  }

  //댓글창에서 POST
  Future<void> postNewTalkComment(
      String content,
      String? mogakId,
      String? catchUpId,
      String? parentId,
      TextEditingController textEditingController,
      {required VoidCallback afterPostSuccess}) async {
    bool success = await _talkController.postNewTalk(
        content, mogakId, catchUpId, parentId);
    if (success) {
      textEditingController.clear();
      Get.snackbar('Success', '댓글이 성공적으로 생성되었습니다.');
      afterPostSuccess();
    } else {
      Get.snackbar('Error', '댓글 생성에 실패했습니다.');
    }
  }

  //팝업창에서 PUT
  Future<void> updateTalkInPopup(BuildContext context,
      TextEditingController textEditingController, String talkId,
      {required VoidCallback afterUpdateSuccess}) async {
    Talk? currentTalk = getCurrentTalk(talkId);

    if (currentTalk == null) {
      Get.snackbar('Error', '해당 톡을 찾을 수 없습니다.');
      return;
    }

    textEditingController.text = currentTalk.content;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return TalkEditingPopup(
          controller: textEditingController,
          onSubmit: () async {
            String updatedContent = textEditingController.text;
            bool success =
                await _talkController.updateTalk(talkId, updatedContent);
            if (success) {
              Get.snackbar('Success', '톡을 성공적으로 업데이트했습니다.');
              Navigator.of(context).pop();
              afterUpdateSuccess();
            } else {
              Get.snackbar('Error', '톡 업데이트에 실패했습니다.');
            }
          },
        );
      },
    );
  }

  //팝업창에서 DELETE
  Future<void> deleteTalkInPopup(BuildContext context, String talkId,
      {required VoidCallback afterDeleteSuccess}) async {
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return DescriptionWithTwoButton(
          mainMessage: '내 톡을 삭제하시겠습니까?',
          subMessage: '한번 삭제하면 복구가 불가능합니다.',
          buttonTitle1: '취소하기',
          buttonTitle2: '삭제하기',
          onSubmit: () async {
            bool success = await _talkController.deleteTalk(talkId);
            if (success) {
              Get.snackbar('Success', '톡 삭제에 성공했습니다.');
              Navigator.pop(dialogContext);
              afterDeleteSuccess();
            } else {
              Get.snackbar('Error', '톡 삭제에 실패했습니다.');
            }
          },
        );
      },
    );
  }

  @override
  void onInit() async {
    super.onInit();
    print('TextEditingController onInit은 되니');
  }
}
