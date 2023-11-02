import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/Home_controller.dart';

class BestSpacerWidget extends StatelessWidget {
  BestSpacerWidget({Key? key}) : super(key: key);

  // HomeController를 직접적으로 참조
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.allBestSpacer.length, // 리스트에 표시할 아이템 수
        itemBuilder: (context, index) {
          final bestSpacer = controller.allBestSpacer[index];
          return Container(
            width: 143,
            height: 165,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage: bestSpacer.avatar != null
                      ? NetworkImage(bestSpacer.avatar!)
                      : null,
                  child: bestSpacer.avatar == null ? Icon(Icons.person) : null,
                ),
                Text(bestSpacer.nickname),
                Text(bestSpacer.role),
                Text(bestSpacer.position),
                Text('Temp: ${bestSpacer.temperature}°'),
              ],
            ),
          );
        },
      );
    });
  }
}
