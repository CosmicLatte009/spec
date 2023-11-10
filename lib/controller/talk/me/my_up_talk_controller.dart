import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/talk/talk_controller.dart';
import '../../../model/me_up.dart';
import '../../../model/talk.dart';
import '../../auth_controller.dart';
import '../../like_controller.dart';

class MyUpTalkController extends GetxController {
  final _authController = Get.find<AuthController>();
  final _likeController = Get.find<LikeController>();
  final _talkController = Get.find<TalkController>();

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

  final Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  final RxList<MeUp> _myUpData = RxList([]);
  final RxList<String> _myUpItemIdList = <String>[].obs;

  RxBool isLoading = true.obs;

  getMyUpData() async {
    try {
      isLoading.value = true;
      var result = await _likeController.myLikeUp(key: MyLikeType.talk);
      _myUpData.assignAll(result);

      _myUpItemIdList.assignAll(_myUpData.map((meUp) => meUp.itemId));

      getMyUpTalkList();
      update();
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  final RxList<Talk> _myUpTalkList = <Talk>[].obs;
  RxList<Talk> get myUpTalkList => _myUpTalkList;

  getMyUpTalkList() async {
    await _talkController.getAllTalks();
    var filteredTalks = _talkController.allTalks
        .where((talk) => _myUpItemIdList.contains(talk.id))
        .toList();
    _myUpTalkList.assignAll(filteredTalks);
    update();
  }

  getAllTalks() => _talkController.getAllTalks();
  getHotTalks() => _talkController.getHotTalks();

  @override
  void onInit() async {
    super.onInit();

    dio.options.baseUrl = baseUrl;

    String? authToken = await getAuth();
    if (authToken != null) {
      dio.options.headers['Authorization'] = authToken;
    }

    await getMyUpData();
  }
}
