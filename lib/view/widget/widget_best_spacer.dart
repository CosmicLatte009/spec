import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/avatar/atavar_with_role.dart';
import 'package:spec/view/widget/avatar/user_avatar.dart';

import '../../controller/Home_controller.dart';

class BestSpacerWidget extends GetView<HomeController> {
  BestSpacerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // temperature 기준으로 내림차순 정렬된 리스트 생성
      var sortedBestSpacers = controller.allBestSpacer.toList()
        ..sort((a, b) => b.temperature.compareTo(a.temperature));

      return Container(
        height: 165,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: sortedBestSpacers.length,
          itemBuilder: (context, index) {
            final bestSpacer = sortedBestSpacers[index];
            return Container(
              width: 143,
              height: 182,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE6E6E6), width: 1),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Container(
                width: 60,
                height: 73,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    UserAvatar(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(bestSpacer.nickname,
                                style: AppTextStyles.body14B()),
                            SizedBox(width: 10),
                            Container(
                                decoration: BoxDecoration(
                                  color: Color(0xF3F3F3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                width: 47,
                                height: 22,
                                child: Center(
                                  child: Text(bestSpacer.role,
                                      style: AppTextStyles.body12R()),
                                )),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.heart_broken),
                        Text('${bestSpacer.temperature}'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
