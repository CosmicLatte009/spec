import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';

enum LikeType { talkId, mogakId, catchUpId }

class LikeController extends GetxController {
  var controller = Get.find<AuthController>();
  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  final RxBool _isLiked = false.obs;

  bool get isLiked => _isLiked.value;

  handleLike(bool isUp) {
    _isLiked(isUp);
  }

  /// 좋아요 업
  likeUp({required LikeType key, required String id}) async {
    String path = '/api/up';
    try {
      var res = await dio.post(path, data: {
        key.name: id,
      });
      if (res.statusCode == 200) {
        if (res.data["status"] == 'success') {
          bool isUp = res.data["data"].isUp;
          handleLike(isUp);
          print('${key.name}: $id 좋아요');
        } else {
          print(res.data["message"]);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;
    //@todo 토큰 header에 설정하기
    String? authToken = await controller.getToken();
    dio.options.headers['Authorization'] = authToken;
  }
}
