import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth/auth_controller.dart';
import 'package:spec/controller/etc/filter_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/model/mogak/mogak.dart';

class JoinedMogakController extends GetxController {
  var controller = Get.find<MogakController>();
  var authController = Get.find<AuthController>();
  var filterController = Get.find<FilterController>();

  final RxList<Mogak> _joinedMogaks = RxList<Mogak>([]);

  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';
  String path = '/api/me/mogak/joined';

  RxList<Mogak> get joinedMogaks => _joinedMogaks;

  mogakState(val) => controller.getMogakState(val);
  isUped(id) => controller.isUped(id);
  toggleLike(id) => controller.toggleLike(id);

  getJoinedMogak() async {
    var queryParameters = {
      'orderBy': filterController.orderBy,
    };
    var res = await dio.get(path, queryParameters: queryParameters);
    if (res.data["data"] != null) {
      _joinedMogaks.value = List<Map<String, dynamic>>.from(res.data["data"])
          .map(
            (mogak) => Mogak.fromMap(mogak),
          )
          .toList();
      return;
    }
    print(res.data["message"]);
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;
    String? authToken = await authController.getToken();

    if (authToken != null) {
      dio.options.headers['Authorization'] = authToken;
    }
    getJoinedMogak();
  }
}
