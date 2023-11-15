import 'package:get/get.dart';
import '../../../model/talk.dart';
import '../talk_controller.dart';

class MyTalkController extends GetxController {
  final _talkController = Get.find<TalkController>();

  RxList<Talk> get myTalkList => _talkController.myTalkList;

  RxBool isLoading = true.obs;

  getMyTalkList() => _talkController.getMyTalkList();

  Future<void> loadMyTalkList() async {
    try {
      isLoading(true);
      await _talkController.getMyTalkList();
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await loadMyTalkList();
  }
}
