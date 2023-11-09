import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/content_search_controller.dart';
import 'package:spec/controller/filter_controller.dart';
import 'package:spec/controller/like_controller.dart';
import 'package:spec/model/detail_mogak.dart';
import 'package:spec/model/me_up.dart';
import 'package:spec/model/mogak.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/widget/alert/360_width_avatar/avatar_with_one_button.dart';

enum VisibilityStatus { hidden, open, close }

class MogakController extends GetxController {
  var controller = Get.find<AuthController>();
  var upController = Get.find<LikeController>();
  var filterController = Get.find<FilterController>();
  var searchController = Get.find<ContentSearchController>();

  String get searchKeyword => searchController.keyword.value;
  final RxList<MeUp> _myLikeList = RxList([]);

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

  getHotMogak({String? query}) async {
    var queryParameters = {
      'orderBy': filterController.orderBy,
      'filter': query,
    };
    try {
      String path = '/api/top/mogak';
      var res = await dio.get(
        path,
        queryParameters: queryParameters,
      );
      _hotMogak.value = List<Map<String, dynamic>>.from(res.data["data"])
          .map(
            (mogak) => Mogak.fromMap(mogak),
          )
          .toList();
    } catch (e) {
      print(e);
    }
  }

  getAllMogak({String? query}) async {
    var queryParameters = {
      'orderBy': filterController.orderBy,
      'filter': query,
    };
    try {
      String path = '/api/mogak';
      var res = await dio.get(
        path,
        queryParameters: queryParameters,
      );
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
          Get.dialog(
            const AvatarWithOneButton(
              mainMessage: '그룹에 참여가 완료되었습니다.',
              buttonTitle: '확인하기',
            ),
          );
          getMogakById(id: mogakId);
        } else {
          Get.dialog(
            AvatarWithOneButton(
              mainMessage: '그룹에 참여하지 못했습니다.',
              subMessage: res.data['message'],
              buttonTitle: '확인하기',
            ),
          );
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
          Get.dialog(
            const AvatarWithOneButton(
              mainMessage: '그룹에 참여가 취소되었습니다.',
              buttonTitle: '확인하기',
            ),
          );
          getMogakById(id: mogakId);
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
          Get.dialog(
            const AvatarWithOneButton(
              mainMessage: '그룹에 삭제가 완료되었습니다.',
              buttonTitle: '확인하기',
            ),
          );
          Get.toNamed(AppPagesRoutes.meMogak);
        } else {
          Get.dialog(
            AvatarWithOneButton(
              mainMessage: '그룹을 삭제하지 못했습니다.',
              subMessage: res.data['message'],
              buttonTitle: '확인하기',
            ),
          );
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
    // dio.interceptors.add(
    //   LogInterceptor(
    //     request: true,
    //     responseBody: true,
    //     requestBody: true,
    //     responseHeader: false, // 필요한 경우 이것도 true로 설정할 수 있습니다.
    //   ),
    // );

    if (authToken != null) {
      dio.options.headers['Authorization'] = authToken;
    }
    await getAllMogak();
    await getHotMogak();
    await getMyUpMogak();
  }
}
