import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/model/me_up.dart';

enum LikeType { talkId, mogakId, catchUpId }

enum MyLikeType { talk, mogak, catchup }

class LikeController extends GetxController {
  var controller = Get.find<AuthController>();
  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';
  final RxList<MeUp> _myUpList = RxList([]);

  List<MeUp> get myUpList => _myUpList;

  /// id를 매개변수로 전달해 현재 upList와 비교.
  bool isUped(String itemId, List<dynamic> upList) {
    // true: heart color: warning
    for (var item in upList) {
      if (item.itemId == itemId) {
        return true;
      }
    }
    return false;
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
          return res.data["data"]["isUp"];
          // print('${key.name}: $id ${res.data["data"]["isUp"]}');
        } else {
          print(res.data["message"]);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  /// 내가 누른 좋아요
  /// talk, mogak, catchup
  myLikeUp({required MyLikeType key}) async {
    String path = '/api/me/up?type=${key.name}';
    try {
      var res = await dio.get(path);
      if (res.statusCode == 200) {
        if (res.data["status"] == 'success') {
          var myLikeList = List<Map<String, dynamic>>.from(res.data["data"])
              .map(
                (up) => MeUp.fromMap(up),
              )
              .toList();
          return myLikeList;
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
    String? authToken = await controller.getToken();
    dio.options.headers['Authorization'] = authToken;
  }
}
