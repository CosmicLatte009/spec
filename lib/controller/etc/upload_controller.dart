import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';

class UploadController extends GetxController {
  var authController = Get.find<AuthController>();
  RxString imageUrl = ''.obs;

  Dio dio = Dio();

  uploadAsset(image) async {
    String path = '/api/upload';
    try {
      var res = await dio.post(path, data: image);
      if (res.data["data"] != null) {
        imageUrl.value = res.data["data"]["url"];
      } else {
        print('return null: ${res.data['message']}');
      }
    } catch (e) {
      print('upload fail: $e');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    String baseUrl = 'https://dev.sniperfactory.com';
    dio.options.baseUrl = baseUrl;
    String? authToken = await authController.getToken();

    if (authToken != null) {
      dio.options.headers['Authorization'] = authToken;
    }
  }
}
