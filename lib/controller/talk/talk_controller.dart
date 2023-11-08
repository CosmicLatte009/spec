import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/like_controller.dart';
import '../../model/talk.dart';
import '../auth_controller.dart';
import 'package:spec/util/api_routes.dart';

class TalkController extends GetxController {
  final _authController = Get.find<AuthController>();
  final _likeController = Get.find<LikeController>();

  //Token 인증
  getAuth() async {
    try {
      var res = await _authController.getToken();
      print(res);
      return res;
    } catch (e) {
      print(e);
    }
  }

  //좋아요
  Future<bool> toggleLike(String talkId) async {
    try {
      bool isUped =
          await _likeController.likeUp(key: LikeType.talkId, id: talkId);
      update();
      return isUped;
    } catch (e) {
      print('Error toggling like status: $e');
      return false;
    }
  }

  checkItemUped(String itemId, List<dynamic> upList) {
    bool uped = _likeController.isUped(itemId, upList);
    // 여기에서 'uped' 값을 기반으로 추가 로직 처리
    if (uped) {
      // 아이템이 upList에 있을 경우의 처리
    } else {
      // 아이템이 upList에 없을 경우의 처리
    }
  }

  //GET: allTalks hotTalks
  final Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  final RxList<Talk> _allTalks = <Talk>[].obs;
  RxList<Talk> get allTalks => _allTalks;
  RxBool isAllTalksLoading = true.obs;

  final RxList<Talk> _hotTalks = <Talk>[].obs;
  RxList<Talk> get hotTalks => _hotTalks;
  RxBool isHotTalksLoading = true.obs;

  getAllTalks() async {
    try {
      isAllTalksLoading.value = true;
      var res = await dio.get(
        ApiRoutes.talk,
      );
      if (res.statusCode == 200 && res.data["status"] == "success") {
        var resData = List<Map<String, dynamic>>.from(res.data["data"]);
        var talkList = resData.map((map) => Talk.fromMap(map)).toList();
        _allTalks.assignAll(talkList);
      } else {
        print(res.data["message"]);
      }
    } on DioException catch (e) {
      print(e.toString());
    } finally {
      isAllTalksLoading.value = false;
    }
  }

  getHotTalks() async {
    try {
      isHotTalksLoading.value = true;
      var res = await dio.get(
        ApiRoutes.hotTalk,
      );
      if (res.statusCode == 200 && res.data["status"] == "success") {
        var resData = List<Map<String, dynamic>>.from(res.data["data"]);
        var talkList = resData.map(Talk.fromMap).toList();
        _hotTalks.assignAll(talkList);
      } else {
        print(res.data["message"]);
      }
    } on DioException catch (e) {
      print(e.toString());
    } finally {
      isHotTalksLoading.value = false;
    }
  }

  getCurrentTalk(String talkId) {
    final talk = _allTalks.firstWhereOrNull((talk) => talk.id == talkId);
    final hotTalk = _hotTalks.firstWhereOrNull((talk) => talk.id == talkId);

    return talk ?? hotTalk;
  }

  //POST
  RxString talkId = ''.obs;
  void setTalkId(String newTalkId) {
    talkId.value = newTalkId;
  }

  Future<bool> postNewTalk(
    String content,
    String? mogakId,
    String? catchUpId,
    String? parentId,
  ) async {
    final Map<String, dynamic> requestData = {
      "content": content,
    };
    if (mogakId != null) requestData['mogakId'] = mogakId;
    if (catchUpId != null) requestData['catchUpId'] = catchUpId;
    if (parentId != null) requestData['parentId'] = parentId;

    try {
      var res = await dio.post(
        ApiRoutes.talk,
        data: requestData,
      );
      if (res.statusCode == 200 && res.data["status"] == "success") {
        print(res);
        return true;
      }
      return false;
    } on DioException catch (e) {
      print('새로운 톡 생성하기 실패여');
      print(e.message);
      return false;
    }
  }

  //PUT
  Future<bool> updateTalk(
    String talkId,
    String content,
  ) async {
    if (talkId.isBlank!) {
      print('톡 ID가 설정되지 않았습니다.');
      return false;
    }
    try {
      String path = '${ApiRoutes.talk}/$talkId';
      var res = await dio.put(path, data: {
        'content': content,
      });
      if (res.statusCode == 200 && res.data["status"] == "success") {
        print(res);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print('톡 수정하기 실패여');
      print(e.message);
      return false;
    }
  }

  //DELETE
  Future<bool> deleteTalk(String talkId) async {
    try {
      String path = '${ApiRoutes.talk}/$talkId';
      var res = await dio.delete(path);
      if (res.statusCode == 200 && res.data["status"] == "success") {
        print(res);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print('톡 삭제하기 실패여');
      print(e.message);
      return false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;

    String? authToken = await getAuth();
    if (authToken != null) {
      dio.options.headers['Authorization'] = authToken;
    }
    print('TalkController onInit은 되니');
  }
}
