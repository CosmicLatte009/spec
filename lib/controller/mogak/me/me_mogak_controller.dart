import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/filter_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/model/mogak.dart';

class MeMogakController extends GetxController {
  var controller = Get.find<MogakController>();
  var authController = Get.find<AuthController>();
  var filterController = Get.find<FilterController>();

  final RxList<Mogak> _meMogaks = RxList([]);

  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';
  String path = '/api/me/mogak';

  RxList<Mogak> get meMogaks => _meMogaks;

  mogakState(val) => controller.getMogakState(val);
  isUped(id) => controller.isUped(id);
  toggleLike(id) => controller.toggleLike(id);

  getMeMogak() async {
    var queryParameters = {
      'orderBy': filterController.orderBy,
    };
    var res = await dio.get(path, queryParameters: queryParameters);
    _meMogaks.value = List<Map<String, dynamic>>.from(res.data["data"])
        .map(
          (mogak) => Mogak.fromMap(mogak),
        )
        .toList();
    print(res.data["data"]);
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;
    String? authToken = await authController.getToken();

    // dio.interceptors.add(
    //   LogInterceptor(
    //     request: true,
    //     responseBody: true,
    //     requestBody: true,
    //     responseHeader: false,
    //   ),
    // );

    dio.options.headers['Authorization'] = authToken;
    getMeMogak();
  }
}
