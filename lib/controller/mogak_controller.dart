import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/model/detail_mogak.dart';
import 'package:spec/model/mogak.dart';

class MogakController extends GetxController {
  DetailMogak? _mogakById;
  final RxList<Mogak> _allMogak = <Mogak>[].obs;
  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  RxList<Mogak>? get allMogak => _allMogak;

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

  getMogakById(String id) async {
    String path = '/api/mogak/$id';
    var res = await dio.get(path);
    _mogakById = res.data["data"]
        .map(
          (mogak) => Mogak.fromMap(mogak),
        )
        .toList();
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;
    await getAllMogak();
  }
}
