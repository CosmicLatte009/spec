import 'package:flutter/material.dart';
import 'package:spec/view/widget/button/button_circle.dart';
import 'package:spec/view/widget/talk/talk_bubble_builder.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import '../../../util/app_color.dart';
import '../../widget/avatar/user_avatar.dart';
import '../../widget/talk/talk_bubble.dart';

class MainTalkPage extends StatelessWidget {
  const MainTalkPage({super.key});

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
          print('호잇');
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
            const NavMenu(
              title: '핫한 톡',
              titleDirection: TitleDirection.left,
              withEmoji: true,
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            const NavMenu(
              title: '톡톡톡',
              titleDirection: TitleDirection.left,
              withEmoji: true,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TalkBubbleBuilder(),
            ),
          ],
        ),
      ),
    );
  }
}
