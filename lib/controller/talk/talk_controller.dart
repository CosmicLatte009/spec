import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/like_controller.dart';
import '../../model/me_up.dart';
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

  bool isMyTalk(String? authorId) {
    String? userId = _authController.getUserId();
    if (userId == authorId) {
      return true;
    } else {
      return false;
    }
  }

  List<MeUp> get myUpList => _likeController.myUpList;

  //좋아요 상태 초기화
  Future<bool> checkIfUserLikedTalk(String talkId) async {
    await fetchMyLikes();
    var like = _likeController.isUped(talkId, _likeController.myUpList);
    return like;
  }

  //내 톡 좋아요 리스트 갱신
  Future<void> fetchMyLikes() async {
    var myLikes = await _likeController.myLikeUp(key: MyLikeType.talk);
    if (myLikes != null && myLikes is List<MeUp>) {
      myUpList.assignAll(myLikes);
      update();
    }
  }

  //좋아요 상태 변경
  Future<bool> toggleLike(String talkId) async {
    try {
      bool isUped =
          await _likeController.likeUp(key: LikeType.talkId, id: talkId);

      return isUped;
    } catch (e) {
      Get.snackbar('Error', '좋아요 상태 변경에 실패했습니다.');

      return false;
    }
  }

  //GET: allTalks hotTalks
  final Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  final RxList<Talk> _allTalks = <Talk>[].obs;
  RxList<Talk> get allTalks => _allTalks;
  RxBool isAllTalksLoading = true.obs;

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

  final RxList<Talk> _hotTalks = <Talk>[].obs;
  RxList<Talk> get hotTalks => _hotTalks;
  RxBool isHotTalksLoading = true.obs;

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

  //Get: detailTalk
  final Rxn<Talk> _detailTalk = Rxn();
  final RxList<Talk> _commentTalks = <Talk>[].obs;

  Rxn<Talk> get detailTalk => _detailTalk;
  RxList<Talk> get commentTalks => _commentTalks;

  RxBool isDetailTalkLoading = true.obs;

  Future<void> getTalkById(String talkId) async {
    isDetailTalkLoading(true);
    try {
      String path = '${ApiRoutes.talk}/$talkId';
      var response = await dio.get(path);

      if (response.statusCode == 200 && response.data["status"] == "success") {
        var talkData = response.data["data"]["talk"];
        var commentsData = response.data["data"]["children"] as List;

        // 상세 토크 저장
        _detailTalk.value = Talk.fromMap(talkData);

        // 댓글 저장
        var newComments = commentsData.map((c) => Talk.fromMap(c)).toList();
        _commentTalks.assignAll(newComments);

        print('get TalkByID 잘되긴 해 $_detailTalk.value');
      }
    } on DioException catch (e) {
      print('단일 톡 불러오기 실패야');
      print(e.toString());
    } finally {
      isDetailTalkLoading(false);
    }
  }

  getCurrentTalk(String id) {
    final talk = allTalks.firstWhereOrNull((t) => t.id == id);
    final hotTalk = hotTalks.firstWhereOrNull((t) => t.id == id);
    if (talk != null) {
      print("Found in allTalks: $talk");
      return talk;
    } else if (hotTalk != null) {
      print("Found in hotTalks: $hotTalk");
      return hotTalk;
    } else {
      print("Talk with ID $id not found in allTalks or hotTalks.");
      return null; // This line is crucial as it ensures a null is returned if not found.
    }
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
        await getTalkById(talkId);
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
