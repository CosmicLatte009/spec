import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/profile_controller.dart';
import 'package:spec/model/my_rank.dart';
import 'package:spec/model/profile.dart';

class MyPageController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.find<ProfileController>();

  Rx<List<MyRank>> myRankInfo = Rx<List<MyRank>>([]);

  final Rxn<Profile> _userInfo = Rxn();
  Profile? get userInfo => _userInfo.value;

  getUserInfo() async {
    String path = '/api/me/profile';
    try {
      var res = await dio.get(path);
      if (res.data['data'] != null) {
        // print('res.data: ${res.data}');
        // print('res.data: ${Profile.fromMap(res.data["data"]).avatar}');
        _userInfo.value = Profile.fromMap(res.data["data"]);
      } else {
        print(res.data["message"]);
      }
    } catch (e) {
      print(e);
    }
  }

  final Dio dio = Dio();

  @override
  void onInit() async {
    super.onInit();
    String baseUrl = 'https://dev.sniperfactory.com';
    dio.options.baseUrl = baseUrl;
    RxString? authToken = RxString(await authController.getToken() ?? "");
    dio.options.headers['Authorization'] = authToken.value;

    if (authToken.value != "") {
      await getUserInfo();
      await fetchMyRank();
    }
  }

  Future<List<MyRank>> fetchMyRank() async {
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
            List<MyRank> myInfos = (data['res'] as List)
                .map((item) => item == null
                    ? null
                    : MyRank.fromMap(item as Map<String, dynamic>))
                .whereType<MyRank>()
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
