import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool hasValue = false.obs;

  String baseUrl = 'https://dev.sniperfactory.com';
  final Dio dio = Dio();

  Future<void> findPassword(String email) async {
    try {
      var res = await dio.post(
          'https://dev.sniperfactory.com/api/auth/forgot-password',
          data: {
            'email': email,
          });
      if (res.statusCode == 200) {
        print(res);
      }
    } on DioException catch (e) {
      print('실패여');
      print(e.message);
    }
  }
}
