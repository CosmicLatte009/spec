import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/view/widget/alert/300_width_icon/icon_text_with_one_button.dart';

class MyPageController extends GetxController {
  final AuthController authController = AuthController(); // 의존성 주입을 위한 생성자

  final BASE_URL = 'https://dev.sniperfactory.com/api/me/rank';
  final Dio _dio = Dio();

  /// Fetches CatchUp data from the API.
  fetchMyInfo() async {
    String? _token = await authController.getToken();

    if (_token == null) {
      print("Token is null");
    }

    try {
      var response = await _dio.get(
        BASE_URL,
        options: Options(headers: {'Authorization': 'Bearer $_token'}),
      );

      if (response.statusCode == 200) {
        var resData = response.data;
        print(resData);
      } else {
        print('Server returned an error: ${response.statusCode}');
      }
    } on DioError catch (dioError) {
      print('Dio error: $dioError');
    } catch (e) {
      print('Error fetching CatchUp data: $e');
    }
  }
}
