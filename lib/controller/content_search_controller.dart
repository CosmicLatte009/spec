import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SearchType { catchup, talk, mogak }

class ContentSearchController extends GetxController {
  var searchTextController = TextEditingController();
  Dio dio = Dio();

  RxString keyword = ''.obs;
  TextEditingController get searchInput => searchTextController;

  @override
  void onInit() {
    super.onInit();
    dio.options.baseUrl = 'https://dev.sniperfactory.com';
  }
}
