import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/model/detail_mogak.dart';
import 'package:spec/model/mogak.dart';

class MogakController extends GetxController {
  var controller = Get.find<AuthController>();

  final RxList<Mogak> _allMogak = <Mogak>[].obs;
  final RxList<Mogak> _hotMogak = <Mogak>[].obs;

  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';

  RxList<Mogak>? get allMogak => _allMogak;
  RxList<Mogak>? get hotMogak => _hotMogak;

  getAuth() async {
    try {
      var res = await controller.getToken();
      print(res);
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
          print(res.data['data']['appliedProfiles']);
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
          print(res.data['data']['appliedProfiles']);
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

  /// 모각 좋아요
  upMogak({required String mogakId}) async {
    String path = '/api/up';
    try {
      var res = await dio.post(path, data: {
        'mogakId': mogakId,
      });
      if (res.statusCode == 200) {
        if (res.data["status"] == 'success') {
          getAllMogak();
          getHotMogak();
          print('$mogakId 좋아요');
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
    String? authToken = await getAuth();

    if (authToken != null) {
      dio.options.headers['Authorization'] = authToken;
    }
    await getAllMogak();
    await getHotMogak();
  }
}
