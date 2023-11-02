import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/util/api_routes.dart';
import '../../model/talk.dart';
import '../auth_controller.dart';

class DetailTalkController extends GetxController {
  var controller = Get.find<AuthController>();
  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  RxString talkId = RxString('');
  final Rxn<Talk> _detailTalk = Rxn();

  Rxn<Talk>? get detailTalk => _detailTalk;

  getAuth() async {
    try {
      var res = await controller.getToken();
      print(res);
      return res;
    } catch (e) {
      print(e);
    }
  }

  getTalkById({required String id}) async {
    try {
      String path = ApiRoutes.talk;
      var res = await dio.get(path + id);
      var talkData = res.data["data"];
      _detailTalk.value = talkData;
      print(_detailTalk);
    } on DioException catch (e) {
      print('단일 톡 실패야');
      print(e.toString());
    }
    print('단일 톡 불러오기는 되니');
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;

    print('단일톡 onInit은 되니');

    String? authToken = await getAuth();

    if (authToken != null) {
      dio.options.headers['Authorization'] = authToken;
    }

    final id = Get.parameters['id'];
    if (id != null) {
      getTalkById(id: id);
    }
  }
}
