// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/talk/all_talk_controller.dart';
import 'package:spec/view/widget/button/button_circle.dart';
import 'package:spec/view/widget/talk/talk_bubble_builder.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import '../../../util/app_color.dart';
import '../../../util/app_page_routes.dart';
import '../../widget/avatar/user_avatar.dart';
import '../../widget/talk/talk_bubble.dart';

class MainTalkPage extends GetView<AllTalkController> {
  const MainTalkPage({super.key});
  static const route = '/talk/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButton: CircleButton(
        svg: 'assets/icons/svgs/Community_white.svg',
        iconWidth: 26,
        backColor: AppColor.primary80,
        buttonWidth: 50,
        onTap: () {
          // controller.getAllTalks();
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (val) {
          print(val);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              child: CustomInput(
                type: InputType.search,
              ),
            ),
            NavMenu(
              title: '핫한 톡',
              titleDirection: TitleDirection.left,
              withEmoji: true,
              onButtonPressed: () => Get.toNamed(AppPagesRoutes.hotTalk),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAvatar(
                    avatarSvg: 'assets/icons/svgs/man-a.svg',
                    direction: BadgeDirection.column,
                    shortName: '개발자/1기',
                    nickName: '캐서린',
                  ),
                  SizedBox(width: 17.02),
                  TalkBubble(
                    text:
                        '근데 15일차 강의 푸신 분 계신가요? 저는 아직 잘 모르겠습니다...혹시 도움 주실 분 계실까요???',
                    isLikePressed: true,
                    type: BubbleType.less,
                    commentCount: 9,
                    upCount: 3,
                    mytalk: true,
                    talkId: 'clo2mqply0002mg08wlnjc5xv',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            NavMenu(
              title: '톡톡톡',
              titleDirection: TitleDirection.left,
              withEmoji: true,
              onButtonPressed: () => Get.toNamed(AppPagesRoutes.allTalk),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return TalkBubbleBuilder(talkDataList: controller.allTalks);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
