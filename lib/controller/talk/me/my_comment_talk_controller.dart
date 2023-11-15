import 'package:get/get.dart';
import 'package:spec/controller/talk/talk_controller.dart';
import '../../../model/talk.dart';

class MyCommentTalkController extends GetxController {
  final _talkController = Get.find<TalkController>();

  RxList<Talk> get myCommentTalkList => _talkController.myCommentTalkList;
  Map<String, Talk?> parentTalks = {};
  RxBool isLoading = true.obs;

  Future<void> _loadParentTalk() async {
    var loadFutures = <Future>[];

    for (var talk in myCommentTalkList) {
      if (talk.parentId != null && !parentTalks.containsKey(talk.parentId)) {
        var future = _talkController.getTalkById(talk.parentId).then((_) {
          parentTalks[talk.parentId!] = _talkController.detailTalk.value;
        });
        loadFutures.add(future);
      }
    }

    await Future.wait(loadFutures);
  }

  getMyTalkList() async {
    isLoading(true);
    try {
      await _talkController.getMyTalkList();
      await _loadParentTalk();
    } finally {
      isLoading(false);
    }
  }

  getAllTalks() => _talkController.getAllTalks();
  getHotTalks() => _talkController.getHotTalks();
  getTalkById(talkId) => _talkController.getTalkById(talkId);

  @override
  void onInit() async {
    super.onInit();
    await getMyTalkList();
  }
}
