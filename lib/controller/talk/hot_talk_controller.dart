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
        // print(hotTalks);
        isLoading.value = false;
      } else {
        isLoading.value = true;
        print(res.data["message"]);
      }
    } on DioException catch (e) {
      isLoading.value = true;
      print(e.toString());
    }
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;
    await getHotTalks();
  }
}
