import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/model/my_profile.dart';

class MyPageController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  var myProfileInfo = <MyProfile>[].obs;

  final String baseUrl = 'https://dev.sniperfactory.com/api/me/rank';
  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchMyInfo();
  }

  // Fetches MyInfo data from the API and returns a list of MyProfile.
  Future<List<MyProfile>> fetchMyInfo() async {
    String? token = await authController.getToken();
    List<MyProfile> profiles = [];

    if (token == null) {
      print("Token is null");
      return profiles;
    }

    try {
      var response = await _dio.get(
        baseUrl,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        var jsonData = response.data;
        print(jsonData);
        profiles = List<MyProfile>.from(
            jsonData.map((item) => MyProfile.fromMap(item)));
        myProfileInfo.value = profiles;
        return profiles;
      } else {
        print('Server returned an error: ${response.statusCode}');
      }
    } on DioError catch (dioError) {
      print('Dio error: $dioError');
    } catch (e) {
      print('Error fetching MyInfo data: $e');
    }

    return profiles;
  }
}
