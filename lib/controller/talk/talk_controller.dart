import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth/auth_controller.dart';
import 'package:spec/controller/etc/like_controller.dart';
import '../../model/talk/talk.dart';
import 'package:spec/util/api_routes.dart';

class TalkController extends GetxController {
  final _authController = Get.find<AuthController>();
  final _likeController = Get.find<LikeController>();

  //Token 인증
  getAuth() async {
    try {
      var res = await _authController.getToken();
      return res;
    } catch (e) {
      print(e);
    }
  }

  //내 톡인지 확인
  bool isMyTalk(String? authorId) {
    String? userId = _authController.getUserId();
    if (userId == authorId) {
      return true;
    } else {
      return false;
    }
  }

  //전체 톡 리스트
  final RxList<Talk> _allTalks = <Talk>[].obs;
  RxList<Talk> get allTalks => _allTalks;

  RxBool isAllTalksLoading = true.obs;

  //핫 톡 변수 리스트
  final RxList<Talk> _hotTalks = <Talk>[].obs;
  RxList<Talk> get hotTalks => _hotTalks;
  RxBool isHotTalksLoading = true.obs;

  //디테일톡 변수, 코멘트톡 리스트
  final Rxn<Talk> _detailTalk = Rxn();
  Rxn<Talk> get detailTalk => _detailTalk;

  final RxList<Talk> _commentTalks = <Talk>[].obs;
  RxList<Talk> get commentTalks => _commentTalks;

  RxBool isDetailTalkLoading = true.obs;

  //내가 작성한 톡 리스트
  final RxList<Talk> _myTalkList = <Talk>[].obs;
  RxList<Talk> get myTalkList => _myTalkList;

  //내가 쓴 이어달린 톡 리스트
  final RxList<Talk> _myCommentTalkList = <Talk>[].obs;
  RxList<Talk> get myCommentTalkList => _myCommentTalkList;

  //내가 좋아요한 톡 리스트
  final RxList<Talk> _myUpTalkList = <Talk>[].obs;
  RxList<Talk> get myUpTalkList => _myUpTalkList;

  final RxMap<String, bool> isLikePressedMap = <String, bool>{}.obs;

  //좋아요 상태 변경
  Future<void> toggleLike(String talkId) async {
    try {
      bool isUped =
          await _likeController.likeUp(key: LikeType.talkId, id: talkId);
      isLikePressedMap[talkId] = isUped;
      print(isUped);
      update();
    } catch (e) {
      Get.snackbar('Error', '좋아요 상태 변경에 실패했습니다.');
    }
  }

  bool isTalkLiked(String talkId) => isLikePressedMap[talkId] ?? false;

  //GET: 내가 좋아요한 톡
  getMyLikes() async {
    try {
      var res = await dio.get(
        'https://dev.sniperfactory.com/api/me/up?type=talk',
      );
      if (res.statusCode == 200 && res.data["status"] == "success") {
        var resData = List<Map<String, dynamic>>.from(res.data["data"]);

        var talkList = resData.map((map) {
          var talk = Talk.fromMap(map['talk']);
          isLikePressedMap[talk.id] = true;
          return talk;
        }).toList();

        _myUpTalkList.assignAll(talkList);

        update();
      } else {
        print(res.data["message"]);
      }
    } on DioException catch (e) {
      print(e.toString());
    }
  }

  //GET: 내가 작성한 톡, 내가 작성한 댓글 톡
  getMyTalkList() async {
    try {
      var res = await dio.get(
        ApiRoutes.myTalk,
      );
      if (res.statusCode == 200 && res.data["status"] == "success") {
        var resData = List<Map<String, dynamic>>.from(res.data["data"]);

        var newMyTalkList = <Talk>[];
        var newMyCommentTalkList = <Talk>[];

        for (var item in resData) {
          var talk = Talk.fromMap(item);
          if (talk.parentId == null &&
              talk.catchUpId == null &&
              talk.mogakId == null) {
            newMyTalkList.add(talk);
          } else if (talk.parentId != null) {
            newMyCommentTalkList.add(talk);
          }
        }
        _myTalkList.assignAll(newMyTalkList);
        _myCommentTalkList.assignAll(newMyCommentTalkList);

        update();
      } else {
        print(res.data["message"]);
      }
    } on DioException catch (e) {
      print(e.toString());
    }
  }

  //GET: allTalks hotTalks
  final Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  Future<void> getAllTalks() async {
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

  //GET: hotTalks
  Future<void> getHotTalks() async {
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

  //GET: detailTalk
  Future<void> getTalkById(String? talkId) async {
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

        print('getTalkById 잘되긴 해 코멘트톡: $_commentTalks.value');
      }
    } on DioException catch (e) {
      print(e.toString());
    } finally {
      isDetailTalkLoading(false);
    }
  }

  //POST
  Future<Talk?> postNewTalk(
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
        Talk newTalk = Talk.fromMap(res.data["data"]);
        update();
        return newTalk;
      }
      return null;
    } on DioException catch (e) {
      print(e.message);
      return null;
    }
  }

  //PUT
  Future<Talk?> updateTalk(
    String talkId,
    String content,
  ) async {
    if (talkId.isBlank!) {
      print('톡 ID가 설정되지 않았습니다.');
      return null;
    }
    try {
      String path = '${ApiRoutes.talk}/$talkId';
      var res = await dio.put(path, data: {
        'content': content,
      });
      if (res.statusCode == 200 && res.data["status"] == "success") {
        Talk updatedTalk = Talk.fromMap(res.data["data"]);

        updateAllRelatedTalkLists(updatedTalk);
        return updatedTalk;
      } else {
        return null;
      }
    } on DioException catch (e) {
      print(e.message);
      return null;
    }
  }

  //DELETE
  Future<bool> deleteTalk(String talkId) async {
    try {
      String path = '${ApiRoutes.talk}/$talkId';
      var res = await dio.delete(path);
      if (res.statusCode == 200 && res.data["status"] == "success") {
        removeTalkFromAllLists(talkId);
        update();

        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print(e.message);
      return false;
    }
  }

  //PUT한 이후 리스트들 한번에 업데이트
  void updateAllRelatedTalkLists(Talk updatedTalk) {
    var index = allTalks.indexWhere((t) => t.id == updatedTalk.id);
    if (index != -1) {
      allTalks[index] = updatedTalk;
    }

    index = hotTalks.indexWhere((t) => t.id == updatedTalk.id);
    if (index != -1) {
      hotTalks[index] = updatedTalk;
    }

    index = commentTalks.indexWhere((t) => t.id == updatedTalk.id);
    if (index != -1) {
      commentTalks[index] = updatedTalk;
    }

    index = myTalkList.indexWhere((t) => t.id == updatedTalk.id);
    if (index != -1) {
      myTalkList[index] = updatedTalk;
    }

    index = myCommentTalkList.indexWhere((t) => t.id == updatedTalk.id);
    if (index != -1) {
      myCommentTalkList[index] = updatedTalk;
    }

    update();
  }

  //DELETE한 이후 리스트들 한번에 업데이트
  void removeTalkFromAllLists(String talkId) {
    allTalks.removeWhere((t) => t.id == talkId);
    hotTalks.removeWhere((t) => t.id == talkId);
    commentTalks.removeWhere((t) => t.id == talkId || t.parentId == talkId);
    myTalkList.removeWhere((t) => t.id == talkId);
    myCommentTalkList
        .removeWhere((t) => t.id == talkId || t.parentId == talkId);

    update();
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;

    String? authToken = await getAuth();
    if (authToken != null) {
      dio.options.headers['Authorization'] = authToken;
    }
  }
}
