import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/Home_controller.dart';
import 'package:spec/view/widget/avatar/user_avatar.dart';

class BestSpacerWidgetHome extends GetView<HomeController> {
  BestSpacerWidgetHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var sortedBestSpacers = controller.allBestSpacer.toList()
        ..sort((a, b) => b.temperature.compareTo(a.temperature));

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 182,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: min(sortedBestSpacers.length, 3),
            itemBuilder: (context, index) {
              final bestSpacer = sortedBestSpacers[index];
              Widget badge;

              if (index == 0) {
                badge = Image.asset(
                  'assets/icons/pngs/1st.png',
                  width: 40,
                  height: 57,
                );
              } else if (index == 1) {
                badge = Image.asset(
                  'assets/icons/pngs/2nd.png',
                  width: 40,
                  height: 57,
                );
              } else if (index == 2) {
                badge = Image.asset(
                  'assets/icons/pngs/3rd.png',
                  width: 40,
                  height: 57,
                );
              } else {
                // 아무것도 표시하지 않음 (빈 컨테이너 사용)
                badge = Container();
              }

              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 143,
                    height: 182,
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE6E6E6), width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        UserAvatar(
                          shortName: bestSpacer.position,
                          nickName: bestSpacer.nickname,
                          direction: BadgeDirection.column,
                          role: bestSpacer.role,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            Text('${bestSpacer.temperature}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 1,
                    child: badge, // 위에서 정의한 badge 위젯을 사용
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
