import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../model/talk.dart';
import '../../../util/api_routes.dart';
import '../../auth_controller.dart';
import '../talk_controller.dart';

class MyTalkController extends GetxController {
  final _authController = Get.find<AuthController>();
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

  final RxList<Talk> _myTalkList = <Talk>[].obs;
  RxList<Talk> get myTalkList => _myTalkList;
  RxBool isMyTalkListLoading = true.obs;

  getMyTalkList() async {
    try {
      isMyTalkListLoading.value = true;
      var res = await dio.get(
        ApiRoutes.myTalk,
      );
      if (res.statusCode == 200 && res.data["status"] == "success") {
        var resData = List<Map<String, dynamic>>.from(res.data["data"]);

        var talkList = resData.map((map) => Talk.fromMap(map)).toList();
        _myTalkList.assignAll(talkList);
      } else {
        print(res.data["message"]);
      }
    } on DioException catch (e) {
      print(e.toString());
    } finally {
      isMyTalkListLoading.value = false;
    }
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

    await getMyTalkList();
  }
}
