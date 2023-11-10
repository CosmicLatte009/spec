import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/talk/talk_controller.dart';
import '../../../model/talk.dart';
import '../../auth_controller.dart';
import 'my_talk_controller.dart';

class MyCommentTalkController extends GetxController {
  final _authController = Get.find<AuthController>();
  final _talkController = Get.find<TalkController>();
  final MyTalkController _myTalkController = Get.find<MyTalkController>();

  //Token 인증
  getAuth() async {
    try {
      var res = await _authController.getToken();
      print(res);
      return res;
    } catch (e) {
      print(e);
    }
  }

  final RxList<Talk> _myCommentTalkList = <Talk>[].obs;
  RxList<Talk> get myCommentTalkList => _myCommentTalkList;
  final RxList<Talk> _myParentTalkList = <Talk>[].obs;

  RxBool isLoading = true.obs;

  getMyTalkList() async {
    isLoading(true);
    try {
      await _myTalkController.getMyTalkList();
      getMyCommentTalkList();
    } finally {
      isLoading(false);
    }
  }

  getMyCommentTalkList() {
    List<Talk> filteredTalks = _myTalkController.myTalkList
        .where((talk) => talk.parentId != null)
        .toList();

    _myCommentTalkList.assignAll(filteredTalks);
  }

  getAllTalks() => _talkController.getAllTalks();
  getHotTalks() => _talkController.getHotTalks();

  @override
  void onInit() async {
    super.onInit();

    await getAuth();

    await getMyTalkList();
  }
}
