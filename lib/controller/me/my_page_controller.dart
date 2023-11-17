import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth/auth_controller.dart';
import 'package:spec/controller/me/profile_controller.dart';
import 'package:spec/model/me/my_rank.dart';
import 'package:spec/model/user/profile.dart';

class MyPageController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.find<ProfileController>();

  Rx<List<MyInfo>> myRankInfo = Rx<List<MyInfo>>([]);

  Profile? get userInfo => authController.myProfile.value;

  final Dio dio = Dio();

  @override
  void onInit() async {
    super.onInit();
    String baseUrl = 'https://dev.sniperfactory.com';
    dio.options.baseUrl = baseUrl;
    RxString? authToken = RxString(await authController.getToken() ?? "");
    dio.options.headers['Authorization'] = authToken.value;

    if (authToken.value != "") {
      await fetchMyRank();
    }
  }

  Future<List<MyInfo>> fetchMyRank() async {
    const String path = '/api/me/rank';

    try {
      var response = await dio.get(
        path,
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
            myRankInfo.value = myInfos;
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
    } on DioException catch (dioError) {
      print('Dio error: $dioError');
      throw Exception('Dio error: $dioError');
    } catch (e) {
      print('Error fetching MyRank data: $e');
      throw Exception('Error fetching MyRank data: $e');
    }
  }
}
