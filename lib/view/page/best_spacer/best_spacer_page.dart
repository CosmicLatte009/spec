import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:spec/controller/Home_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/view/widget/avatar/user_avatar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/widget_best_spacer_page.dart';

// 반구를 그리는 CustomPainter
class HalfCirclePainter extends CustomPainter {
  final Color color;
  final double height;

  HalfCirclePainter({required this.color, required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, 0)
      ..arcTo(
        Rect.fromCenter(
            center: Offset(size.width / 2, 0),
            width: size.width,
            height: height * 1),
        math.pi, // 시작 각도
        -math.pi, // 스윕 각도(음수값으로 뒤집힌 반구를 그립니다)
        false,
      )
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BestSpacerPage extends GetView<HomeController> {
  BestSpacerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var sortedBestSpacers = controller.allBestSpacer.toList()
        ..sort((a, b) => b.temperature.compareTo(a.temperature));

      return Scaffold(
        appBar: CustomAppBar(),
        body: Stack(
          children: [
            Positioned(
              top: 0, // AppBar 높이만큼 top을 설정합니다.
              left: 0,
              right: 0,

              child: Container(
                height: 281,
                width: 390,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70),
                    ),
                    color: AppColor.primary80),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 8.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  NavMenu(
                    title: '이달의 스페이서',
                    titleDirection: TitleDirection.center,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Image.asset('assets/images/Graphic4.png'),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BestSpacerWidgetPage(
                        bestSpacer: sortedBestSpacers[1],
                        badge: Image.asset('assets/icons/pngs/2nd.png',
                            width: 30, height: 43), // 2등 뱃지
                      ),
                      BestSpacerWidgetPage(
                        bestSpacer: sortedBestSpacers[0],
                        isFirstPlace: true,
                        badge: Image.asset('assets/icons/pngs/1st.png',
                            width: 40, height: 57), // 1등 뱃지
                      ),

                      BestSpacerWidgetPage(
                        bestSpacer: sortedBestSpacers[2],
                        badge: Image.asset('assets/icons/pngs/3rd.png',
                            width: 30, height: 43), // 3등 뱃지
                      ),
                      // 나머지 스페이서 위젯들...
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: sortedBestSpacers.length - 3,
                      itemBuilder: (context, index) {
                        final bestSpacer = sortedBestSpacers[index + 3];
                        return Card(
                          child: Container(
                            width: 370,
                            height: 70,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                UserAvatar(
                                  shortName: bestSpacer.position,
                                  nickName: bestSpacer.nickname,
                                  direction: BadgeDirection.row,
                                  role: bestSpacer.role,
                                  avatarSize: AvatarSize.w40,
                                ),
                                Spacer(),
                                Icon(Icons.favorite,
                                    color: Colors.red, size: 15),
                                SizedBox(width: 5),
                                Text('${bestSpacer.temperature}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
