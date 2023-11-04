import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/like_controller.dart';
import 'package:spec/model/detail_mogak.dart';
import 'package:spec/model/me_up.dart';
import 'package:spec/model/mogak.dart';
import 'package:spec/util/app_page_routes.dart';

enum VisibilityStatus { hidden, open, close }

class MogakController extends GetxController {
  var controller = Get.find<AuthController>();
  var upController = Get.find<LikeController>();
  final RxList<MeUp> _myLikeList = RxList([]);

  List<MeUp> get myLikeList => _myLikeList;

  /// 좋아요 토글
  toggleLike(String mogakId) {
    var res = upController.likeUp(
      key: LikeType.mogakId,
      id: mogakId,
    );
    return res;
  }

  /// 내 up인지 확인
  bool isUped(String id) {
    return upController.isUped(id, _myLikeList);
  }

  /// 내 모든 up mogak 리스트
  getMyUpMogak() async {
    _myLikeList(
      await upController.myLikeUp(key: MyLikeType.mogak),
    );
  }

  final RxList<Mogak> _allMogak = <Mogak>[].obs;
  final RxList<Mogak> _hotMogak = <Mogak>[].obs;

  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  RxList<Mogak>? get allMogak => _allMogak;
  RxList<Mogak>? get hotMogak => _hotMogak;

  getMogakState(val) {
    switch (val) {
      case "CLOSE":
        return '모집완료';
      case "HIDDEN":
        return '작성중';
      case "OPEN":
        return '모집중';
      default:
        return null;
    }
  }

  getAuth() async {
    try {
      var res = await controller.getToken();
      return res;
    } catch (e) {
      print(e);
    }
  }

  getHotMogak() async {
    try {
      String path = '/api/top/mogak';
      var res = await dio.get(path);
      _hotMogak.value = List<Map<String, dynamic>>.from(res.data["data"])
          .map(
            (mogak) => Mogak.fromMap(mogak),
          )
          .toList();
    } catch (e) {
      print(e);
    }
  }

  getAllMogak() async {
    try {
      String path = '/api/mogak';
      var res = await dio.get(path);
      _allMogak.value = List<Map<String, dynamic>>.from(res.data["data"])
          .map(
            (mogak) => Mogak.fromMap(mogak),
          )
          .toList();
    } catch (e) {
      print(e);
    }
  }

  getMogakById({required String id}) async {
    try {
      String path = '/api/mogak/$id';
      var res = await dio.get(path);
      return DetailMogak.fromMap(res.data["data"]);
    } catch (e) {
      print(e);
    }
  }

  /// 모각 신청
  joinMogak({required String mogakId}) async {
    String path = '/api/mogak/$mogakId/apply';
    try {
      var res = await dio.post(path);
      if (res.statusCode == 200) {
        if (res.data['status'] == 'success') {
          getMogakById(id: mogakId); //새로고침? 내가 리스트에 나와야함.
        } else {
          print(res.data['message']);
        }
      } else {
        print(res.data['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  /// 모각 참여 취소
  cancelJoin({required String mogakId}) async {
    String path = '/api/mogak/$mogakId/apply';
    try {
      var res = await dio.delete(path);
      if (res.statusCode == 200) {
        if (res.data['status'] == 'success') {
          getMogakById(id: mogakId); //새로고침? 내가 리스트에 나와야함.
        } else {
          print(res.data['message']);
        }
      } else {
        print(res.data['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteMogak({required String mogakId}) async {
    String path = '/api/mogak/$mogakId';
    try {
      var res = await dio.delete(path);
      if (res.statusCode == 200) {
        if (res.data['status'] == 'success') {
          Get.toNamed(AppPagesRoutes.allMogak);
        } else {
          print(res.data['message']);
        }
      } else {
        print(res.data['message']);
      }
    } catch (e) {
      print(e);
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
    await getAllMogak();
    await getHotMogak();
    await getMyUpMogak();
  }
}
