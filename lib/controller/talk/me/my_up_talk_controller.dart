import 'package:get/get.dart';
import 'package:spec/controller/talk/talk_controller.dart';
import '../../../model/talk.dart';

class MyUpTalkController extends GetxController {
  final TalkController _talkController = Get.find<TalkController>();

  RxList<Talk> get myUpTalkList => _talkController.myUpTalkList;

  final RxBool isLoading = true.obs;

  Future<void> getMyUpTalkList() async {
    isLoading.value = true;
    try {
      await _talkController.getMyLikes();
    } catch (e) {
      print('내가 좋아요한 톡 불러오기 실패: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getMyUpTalkList();
  }
}
