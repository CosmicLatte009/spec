import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spec/controller/my_page_controller.dart';

class MyPage extends GetView<MyPageController> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text('My Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            controller.fetchMyInfo();
          },
          child: Text('Fetch My Info'),
        ),
      ),
    );
  }
}
