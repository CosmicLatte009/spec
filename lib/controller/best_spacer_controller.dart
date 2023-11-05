import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/model/best_spacer.dart';
import 'package:spec/model/catchup.dart';
import 'package:spec/model/course.dart';

class BestSpacerController extends GetxController {
  var allCourse = <Course>[].obs;
  var allBestSpacer = <BestSpacer>[].obs;
  Rx<List<CatchUp>> hotCatchUpCategory = Rx<List<CatchUp>>([]);

  final Dio _dio = Dio(); // Made final
  static const BASE_URL =
      'https://dev.sniperfactory.com/api/course'; // Naming convention
  AuthController _authController = AuthController(); // Singleton pattern

  @override
  void onInit() {
    super.onInit();

    fetchBestSpacerData();
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
}
