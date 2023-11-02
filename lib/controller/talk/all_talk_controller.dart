import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/util/api_routes.dart';
import '../../model/talk.dart';

class AllTalkController extends GetxController {
  final RxList<Talk> _allTalks = <Talk>[].obs;
  RxList<Talk> get allTalks => _allTalks;
  RxBool isLoading = true.obs;

  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  getAllTalks() async {
    try {
      isLoading.value = true;
      var res = await dio.get(
        ApiRoutes.talk,
      );
      if (res.statusCode == 200 && res.data["status"] == "success") {
        var resData = List<Map<String, dynamic>>.from(res.data["data"]);
        var talkList = resData.map(Talk.fromMap).toList();
        _allTalks.assignAll(talkList);
        isLoading.value = false;
        print(_allTalks);
      } else {
        isLoading.value = true;
        print(res.data["message"]);
      }
    } on DioException catch (e) {
      isLoading.value = true;
      print('전체 톡 가져오기 실패여');
      print(e.toString());
    }
    // print('요청을 보내고 있긴 하니');
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;
    await getAllTalks();
    print('onInit은 되긴 되니');
  }
}
