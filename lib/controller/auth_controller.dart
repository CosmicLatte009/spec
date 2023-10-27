import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide FormData;

class AuthController extends GetxController {
  // final RxBool isError = false.obs;
  // final RxBool isSuccess = true.obs;

  final RxInt isLoggedIn = RxInt(-1);
  //로그인 구현

  final BASE_URL = 'https://dev.sniperfactory.com/api/auth/login';
  final storage = new FlutterSecureStorage();
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
          await storage.write(key: 'jwt_token', value: token);
          print(resData);
        } else if (token == null) {
          isLoggedIn.value = 0;
          print('실패!');
        }
      }
    } catch (e) {
      print('에러: $e');
    }
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
}
