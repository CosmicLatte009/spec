import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/model/my_profile.dart';
import 'package:spec/model/my_rank.dart';

class MyPageController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  Rx<List<MyInfo>> myProfileInfo = Rx<List<MyInfo>>([]);

  final String baseUrl = 'https://dev.sniperfactory.com/api/me/rank';
  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchMyInfo();
  }

  Future<List<MyInfo>> fetchMyInfo() async {
    String? token = await authController.getToken();
    List<MyInfo> profiles = [];

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
        if (jsonData['status'] == 'success' && jsonData['data'] != null) {
          var data = jsonData['data'];
          if (data['res'] is List) {
            List<MyInfo> myInfos = (data['res'] as List)
                .map((item) => item == null
                    ? null
                    : MyInfo.fromMap(item as Map<String, dynamic>))
                .whereType<MyInfo>()
                .toList();
            print("myInfos: ${myProfileInfo.value}");
            myProfileInfo.value = myInfos;
            return myInfos;
          } else {
            throw Exception('Invalid format for "res" field, expected a List.');
          }
        } else {
          throw Exception('Request failed with status: ${jsonData['status']}');
        }
      } else {
        print('Server returned an error: ${response.statusCode}');
        throw Exception(
            'Server error with status code: ${response.statusCode}');
      }
    } on DioError catch (dioError) {
      print('Dio error: $dioError');
      throw Exception('Dio error: $dioError');
    } catch (e) {
      print('Error fetching MyInfo data: $e');
      throw Exception('Error fetching MyInfo data: $e');
    }
  }
}
