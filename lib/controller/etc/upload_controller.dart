import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth/auth_controller.dart';
import 'package:spec/view/widget/alert/360_width_avatar/avatar_with_one_button.dart';

class UploadController extends GetxController {
  var authController = Get.find<AuthController>();
  RxString imageUrl = ''.obs;

  Dio dio = Dio();

  uploadAsset(image) async {
    dio.options.contentType = 'multipart/form-data';
    String path = '/api/upload';
    try {
      var res = await dio.post(path, data: image);
      if (res.data["data"] != null) {
        imageUrl.value = res.data["data"][0]["url"];
      } else {
        Get.dialog(
          AvatarWithOneButton(
            mainMessage: '아바타를 수정하지 못했습니다.',
            subMessage: res.data['message'],
            buttonTitle: '확인하기',
          ),
        );
      }
    } catch (e) {
      print('uploadAsset: $e');
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
