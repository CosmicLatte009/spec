import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/util/api_routes.dart';
import '../../model/talk.dart';

class HotTalkController extends GetxController {
  final RxList<Talk> _hotTalks = <Talk>[].obs;
  RxList<Talk> get hotTalks => _hotTalks;
  RxBool isLoading = true.obs;

  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  getHotTalks() async {
    try {
      isLoading.value = true;
      var res = await dio.get(
        ApiRoutes.hotTalk,
      );
      if (res.statusCode == 200 && res.data["status"] == "success") {
        var resData = List<Map<String, dynamic>>.from(res.data["data"]);
        var talkList = resData.map(Talk.fromMap).toList();
        _hotTalks.assignAll(talkList);
        isLoading.value = false;
        print(_hotTalks);
      } else {
        isLoading.value = true;
        print(res.data["message"]);
      }
    } on DioException catch (e) {
      isLoading.value = true;
      print('핫한 톡 가져오기 실패여');
      print(e.toString());
    }
    // print('요청을 보내고 있긴 하니');
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;
    await getHotTalks();
    print('핫톡 컨트롤러 onInit은 되긴 되니');
  }
}
