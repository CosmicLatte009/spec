import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/model/detail_mogak.dart';
import 'package:spec/model/mogak.dart';

class MogakController extends GetxController {
  var controller = Get.find<AuthController>();

  final RxList<Mogak> _allMogak = <Mogak>[].obs;
  final RxList<Mogak> _hotMogak = <Mogak>[].obs;

  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  RxList<Mogak>? get allMogak => _allMogak;
  RxList<Mogak>? get hotMogak => _hotMogak;

  getHotMogak() async {
    try {
      String path = '/api/top/mogak';
      var res = await dio.get(path);
      _hotMogak.value = List<Map<String, dynamic>>.from(res.data["data"])
          .map(
            (mogak) => Mogak.fromMap(mogak),
          )
          .toList();
    } catch (e) {
      print(e);
    }
  }

  getAllMogak() async {
    try {
      String path = '/api/mogak';
      var res = await dio.get(path);
      _allMogak.value = List<Map<String, dynamic>>.from(res.data["data"])
          .map(
            (mogak) => Mogak.fromMap(mogak),
          )
          .toList();
    } catch (e) {
      print(e);
    }
  }

  getMogakById({required String id}) async {
    try {
      String path = '/api/mogak/$id';
      var res = await dio.get(path);
      print(res.data); //인증 필요
      return DetailMogak.fromMap(res.data["data"]);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;
    //@todo 토큰 header에 설정하기
    // dio.options.headers
    await getAllMogak();
    await getHotMogak();
  }
}
