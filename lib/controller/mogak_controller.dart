import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/model/detail_mogak.dart';
import 'package:spec/model/mogak.dart';

class MogakController extends GetxController {
  DetailMogak? _mogakById;
  List<Mogak>? _allMogak = [];
  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  List<Mogak>? get allMogak => _allMogak;

  getAllMogak() async {
    String path = '/api/mogak';
    var res = await dio.get(path);
    _allMogak = List<Map<String, dynamic>>.from(res.data["data"])
        .map(
          (mogak) => Mogak.fromMap(mogak),
        )
        .toList();
    // print(_allMogak);
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
  void onInit() {
    super.onInit();
    dio.options.baseUrl = baseUrl;
    getAllMogak();
  }
}
