import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/model/best_spacer.dart';
import 'package:spec/model/catchup.dart';
import 'package:spec/model/course.dart';

class HomeController extends GetxController {
  var allCourse = <Course>[].obs;
  var allBestSpacer = <BestSpacer>[].obs;
  Rx<List<CatchUp>> hotCatchUpCategory = Rx<List<CatchUp>>([]);
  Rx<List<CatchUp>> HomeHotCatchUps = Rx<List<CatchUp>>([]);

  final Dio _dio = Dio(); // Made final
  static const BASE_URL =
      'https://dev.sniperfactory.com/api/course'; // Naming convention
  AuthController _authController = AuthController(); // Singleton pattern

  @override
  void onInit() {
    super.onInit();
    fetchHomeData(); // Fetch data when the controller is initialized
    fetchBestSpacerData();
    fetchHomeHotCatchup();
  }

  Future<List<Course>> fetchHomeData() async {
    final token = await _authController.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await _dio.get(
        BASE_URL,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        var resData = response.data['data'];
        if (response.data['data'] is List) {
          List<Course> courses = (response.data['data'] as List)
              .map((courseData) => Course.fromJson(courseData))
              .toList();
          allCourse.value = courses;
          return courses;
        } else {
          throw Exception('Invalid data format received from server');
        }
      } else {
        throw Exception('Failed to fetch home data');
      }
    } on DioError catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<Course>> fetchCourseData() async {
    final token = await _authController.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await _dio.get(
        BASE_URL,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        var resData = response.data['data'];
        if (response.data['data'] is List) {
          List<Course> courses = (response.data['data'] as List)
              .map((courseData) => Course.fromJson(courseData))
              .toList();
          allCourse.value = courses;
          return courses;
        } else {
          throw Exception('Invalid data format received from server');
        }
      } else {
        throw Exception('Failed to fetch home data');
      }
    } on DioError catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<BestSpacer>> fetchBestSpacerData() async {
    final token = await _authController.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await _dio.get(
        'https://dev.sniperfactory.com/api/top/sfacer',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        var resData = response.data['data'];
        print(resData);
        if (resData is List) {
          List<BestSpacer> bestSpacers =
              resData.map((json) => BestSpacer.fromMap(json)).toList();
          allBestSpacer.value = bestSpacers;
          return bestSpacers;
        } else {
          throw Exception('Invalid data format received from server');
        }
      } else {
        throw Exception('Failed to fetch best spacer data');
      }
    } on DioError catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<CatchUp>> fetchHomeHotCatchup() async {
    final token = await _authController.getToken();
    if (token == null) {
      print("Token is null");
      return HomeHotCatchUps.value; // 토큰이 null이면 현재 값을 반환
    }

    try {
      var url = 'https://dev.sniperfactory.com/api/top/catchup';
      var response = await _dio.get(url,
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        var resData = response.data;
        print(resData);

        List<CatchUp> HomeHotCatchUpsList =
            List<Map<String, dynamic>>.from(resData)
                .map((item) => CatchUp.fromMap(item))
                .toList();
        HomeHotCatchUps.value = HomeHotCatchUpsList;

        return HomeHotCatchUpsList;
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
}
