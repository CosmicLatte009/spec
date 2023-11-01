// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AllTalksController extends GetxController {
  RxBool hasValue = false.obs;

  String baseUrl = 'https://dev.sniperfactory.com';
  Dio dio = Dio();

  getAllTalks() async {
    try {
      var res = await dio.get(
        'https://dev.sniperfactory.com/api/talk',
      );
      if (res.statusCode == 200 && res.data["status"] == "success") {
        print(res);
      } else {
        print(res.data["message"]);
      }
    } on DioException catch (e) {
      print('전체 톡 가져오기 실패여');
      print(e.message);
    }
    print('되긴 되니');
  }

  @override
  void onInit() async {
    super.onInit();
    await getAllTalks();
  }
}
