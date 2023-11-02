import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/detail_mogak_controller.dart';
import 'package:spec/view/widget/card/detail_mogak_card.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';

class DetailMogakPage extends GetView<DetailMogakController> {
  static const route = '/mogak/:id';

  const DetailMogakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(controller.detailMogak.toString()),
          // if (controller.detailMogak != null)
          //   Obx(
          //     () => DetailMogakCard(
          //       mogak: controller.detailMogak!,
          //     ),
          //   ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        onTap: (val) {
          print(val);
        },
      ),
    );
  }
}
