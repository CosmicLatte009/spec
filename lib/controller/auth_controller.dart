import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide FormData;
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/page/home_page.dart';
import 'package:spec/view/page/splash_page.dart';
import 'package:spec/view/widget/alert/300_width_icon/icon_text_with_one_button.dart';

import '../model/my_profile.dart';

class AuthController extends GetxController {
  final RxInt isLoggedIn = RxInt(-1);
  String? readToken;

  //로그인 구현

  final BASE_URL = 'https://dev.sniperfactory.com/api/auth/login';
  final storage = const FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<void> login(String id, String pw) async {
    final String email = id;
    final String password = base64Encode(utf8.encode(pw));

    try {
      final response = await _dio.post(
        BASE_URL,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        var resData = response.data;
        var token = resData['data'];

        if (token != null) {
          isLoggedIn.value = 1;
          print('성공');
          await storage.write(key: 'jwt_token', value: token);
          readToken = await storage.read(key: 'jwt_token');

          if (readToken != null) {
            print(readToken);

            getMyInfo();

            Get.to(() => const HomePage());
          }
        } else if (token == null) {
          isLoggedIn.value = 0;
          await Future.delayed(
              const Duration(milliseconds: 300)); // 로그인 로직이 비동기일 경우 대기
          if (isLoggedIn.value == 0) {
            // 로그인 실패 시 다이얼로그 표시
            void showLoginFailDialog() {
              Get.dialog(
                const IconTextWithOneButton(
                  svgPath: 'assets/icons/svgs/Warning.svg',
                  mainMessage: '로그인에 실패했습니다.',
                  buttonTitle: '다시하기',
                  subMessage: '다시 시도해주세요.',
                ),
              ); // 실패 시 표시할 다이얼로그
            }

            showLoginFailDialog();
          }
          print('실패!');
        }
      }
    } catch (e) {
      print('에러: $e');
    }
  }

  final Rxn<MyProfile> _myProfile = Rxn();
  Rxn<MyProfile> get myProfile => _myProfile;

  getMyInfo() async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    try {
      var res = await _dio.get(
        'https://dev.sniperfactory.com/api/me/profile',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
      if (res.statusCode == 200 && res.data["status"] == "success") {
        var resData = res.data["data"];
        _myProfile.value = MyProfile.fromMap(resData);
      } else {
        print(res.data["message"]);
      }
    } on DioException catch (e) {
      print(e.toString());
    }
  }

  String? getUserId() {
    return _myProfile.value?.id;
  }

  Future<String?> getToken() {
    return storage.read(key: 'jwt_token');
  }

  //회원탈퇴
  // 더미 엔드포인트
  final String deleteAccountURL =
      'https://dev.sniperfactory.com/api/auth/withdraw';

  void deleteAccount() async {
    try {
      // 사용자 고유 ID 예: 123
      final response = await _dio.post(deleteAccountURL, data: {'userId': 123});

      if (response.statusCode == 200) {
        print('성공!'); // 계정 성공적으로 삭제

        // 로그아웃 로직 실행
        //logout();

        // 홈 페이지 또는 다른 페이지로 리다이렉션
        //Get.offAll(HomePage());

        // 성공 메시지 표시
        Get.snackbar('성공', '계정이 성공적으로 삭제되었습니다.');
      } else {
        // 에러 처리
        Get.snackbar('오류', '계정을 삭제하는 데 실패했습니다. 다시 시도하세요.');
      }
    } catch (e) {
      print(e);
      Get.snackbar('오류', '오류가 발생했습니다. 다시 시도하세요.');
    }
  }

  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    currentPassword = base64Encode(utf8.encode(currentPassword));
    newPassword = base64Encode(utf8.encode(newPassword));

    final token = await getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      var response = await _dio.post(
          'https://dev.sniperfactory.com/api/auth/change-password',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }),
          data: {
            'currentPassword': currentPassword,
            'newPassword': newPassword
          });

      if (response.statusCode == 200) {
        print(currentPassword);
        print(newPassword);

        // 요청이 성공했다면, 처리 결과에 따라 반환
        if (response.data['data'] == null) {
          void showLoginFailDialog() {
            Get.dialog(
              const IconTextWithOneButton(
                svgPath: 'assets/icons/svgs/Warning.svg',
                mainMessage: '로그인에 실패하였습니다.',
                buttonTitle: '다시하기',
                subMessage: '다시 시도해주세요.',
              ),
            ); // 실패 시 표시할 다이얼로그
          }

          showLoginFailDialog();
        }
        print(response.data);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      return false;
    } catch (e) {
      print('Unexpected error: $e');
      return false;
    }
  }

  void logout() async {
    try {
      await storage.delete(key: 'jwt_token');
      Get.to(() => const SplashPage());
    } catch (e) {
      print('토큰 삭제 오류: $e');
      Get.snackbar('오류', '로그아웃 중 오류가 발생했습니다.');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getMyInfo();
  }
}


//   void logout() {
//     // 로그아웃 로직 구현, 예: 토큰 삭제, 사용자 데이터 삭제 등.
//     Future<void> deleteToken() async {
//       try {
//         await storage.delete(key: 'jwt_token');
//         Get.snackbar('성공', '토큰이 성공적으로 삭제되었습니다.');
//       } catch (e) {
//         print('토큰 삭제 오류: $e');
//         Get.snackbar('오류', '토큰 삭제 중 오류가 발생했습니다.');
//       }
//     }
//   }
// }

