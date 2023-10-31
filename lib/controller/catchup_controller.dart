import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/model/catchup.dart';

class CatchUpController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  var allCatchUps = <CatchUp>[].obs; // 전체 캐치업 리스트

  final Dio dio = Dio();

  var isUp = false.obs;
  var likeCount = 0.obs;

  var isClicked = false.obs;

  Rx<List<CatchUp>> catchUps = Rx<List<CatchUp>>([]);
  Rx<List<CatchUp>> searchCatchUps = Rx<List<CatchUp>>([]);

  var filteredCatchUps = <CatchUp>[].obs; // 필터링된 목록

  void filterCatchUps(String category) {
    var filteredList = catchUps.value.where((catchUp) {
      return catchUp.category?.contains(category) ?? false;
    }).toList();
    hotCatchUps.value = filteredList;
  }

  Rx<List<CatchUp>> hotCatchUps = Rx<List<CatchUp>>([]);
  // 선택된 해시태그를 추적하는 RxString 변수
  RxString selectedCategory = RxString('');
  // 선택된 해시태그를 설정하는 함수
  void setSelectedHashTag(String category) {
    selectedCategory.value = category;
  }

  void filterCatchUpsByCategory(String category) {
    selectedCategory.value = category;
    if (category.isEmpty) {
      filteredCatchUps.value = allCatchUps; // 모든 항목 표시
    } else {
      filteredCatchUps.value = allCatchUps.where((item) {
        return item.category == category; // 카테고리가 일치하는 항목만 필터링
      }).toList();
    }
  }

  void handleSubmit(String searchText) async {
    if (searchText.isNotEmpty) {
      await fetchCatchUpWithSearch(searchTextcontroller.text);
    } else {
      searchCatchUps.value = [];
    }
  }

  var isSearching = false.obs;

  // 검색 시작 시 호출될 메서드
  startSearch(String query) {
    isSearching.value = true;
    fetchCatchUpWithSearch(query);
  }

  // 검색 종료 시 호출될 메서드
  endSearch() {
    isSearching.value = false;
    searchTextcontroller.clear();
  }

  var searchTextcontroller = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCatchUp(); // 컨트롤러 초기화시 데이터 로드
    searchTextcontroller.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    if (searchTextcontroller.text.isEmpty) {
      endSearch(); // 검색 종료 함수
    }
  }

  /// Fetches CatchUp data from the API.
  Future<List<CatchUp>> fetchCatchUp() async {
    String? _token = _authController.dmddo;

    if (_token == null) {
      print("Token is null");
      return catchUps.value; // 기존 값 반환
    }

    try {
      var response = await dio.get(
        'https://dev.sniperfactory.com/api/catchup?filter=',
        options: Options(headers: {'Authorization': 'Bearer $_token'}),
      );

      if (response.statusCode == 200) {
        var resData = response.data;

        if (resData != null && resData['data'] != null) {
          List<CatchUp> fetchedCatchUps =
              List<Map<String, dynamic>>.from(resData['data'])
                  .map((item) => CatchUp.fromJson(item))
                  .toList();
          print(fetchedCatchUps);
          catchUps.value = fetchedCatchUps;
          return fetchedCatchUps;
        } else {
          print('Data is null');
          return catchUps.value; // 기존 값 반환
        }
      } else {
        print('Server returned an error: ${response.statusCode}');
        return catchUps.value; // 기존 값 반환
      }
    } on DioError catch (dioError) {
      print('Dio error: $dioError');
      return catchUps.value; // 기존 값 반환
    } catch (e) {
      print('Error fetching CatchUp data: $e');
      return catchUps.value; // 기존 값 반환
    }
  }

  Future<List<CatchUp>> HotCatchup() async {
    String? _token = _authController.dmddo;
    print(_token);
    if (_token == null) {
      print("Token is null");
      return hotCatchUps.value; // 토큰이 null이면 현재 값을 반환
    }

    try {
      var url = 'https://dev.sniperfactory.com/api/top/catchup';
      var response = await dio.get(url,
          options: Options(headers: {'Authorization': 'Bearer $_token'}));

      if (response.statusCode == 200) {
        var resData = response.data;
        print(resData);
        print(resData.runtimeType);

        List<CatchUp> HotCatchUpsList = List<Map<String, dynamic>>.from(resData)
            .map((item) => CatchUp.fromJson(item))
            .toList();
        hotCatchUps.value = HotCatchUpsList;
        print(HotCatchUpsList);
        return HotCatchUpsList;
      } else {
        return []; // 유효하지 않은 데이터 형식의 경우 빈 리스트 반환
      }
    } on DioError catch (dioError) {
      print('Dio error: $dioError');
      return []; // Dio 오류의 경우 빈 리스트 반환
    } catch (e) {
      print('Error fetching HotCatchup data: $e');
      return []; // 기타 예외의 경우 빈 리스트 반환
    }
  }

  Future<List<CatchUp>> fetchCatchUpWithSearch(String query) async {
    try {
      String baseUrl = 'https://dev.sniperfactory.com/api/catchup?filter=';
      // Uri.encodeQueryComponent를 사용하여 쿼리 인코딩 처리
      String encodedQuery = Uri.encodeQueryComponent(query);
      var response = await Dio().get(baseUrl + encodedQuery);

      if (response.statusCode == 200) {
        print('성공');
        // 데이터 유효성 검사 추가
        if (response.data != null &&
            response.data.containsKey('data') &&
            response.data['data'] is List) {
          List<CatchUp> searchedCatchUps = (response.data['data'] as List)
              .map((item) => CatchUp.fromJson(item))
              .toList();
          print(searchedCatchUps);

          searchCatchUps.value = searchedCatchUps;
          return searchedCatchUps;
        } else {
          print('Invalid data format');
        }
      } else {
        print('Server returned an error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching CatchUp data with search: $e');
    }

    return []; // 오류 발생 시 빈 리스트 반환
  }

  var likes = <String, bool>{}.obs; // 각 catchUpId별 좋아요 상태 관리

  bool isLiked(String catchUpId) {
    return likes[catchUpId] ?? false;
  }

  sendLike(String catchUpId) async {
    String? _tokenLike = _authController.dmddo;
    print(_tokenLike);

    try {
      final response = await dio.post(
        'https://dev.sniperfactory.com/api/up',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_tokenLike',
          },
        ),
        data: {'catchUpId': catchUpId},
      );

      if (response.statusCode == 200) {
        if (likes.containsKey(catchUpId)) {
          likes[catchUpId] = !likes[catchUpId]!;
        } else {
          likes[catchUpId] = true; // 처음 좋아요를 누른 경우
        }
        // 여기서 API 요청 로직 구현 (예: Dio 요청)
        update(); // UI 업데이트

        print('좋아요 요청 성공: ${response.data}');
      } else {
        print('좋아요 요청 실패: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('좋아요 요청 중 에러 발생: ${e.message}');
    }
  }
}
