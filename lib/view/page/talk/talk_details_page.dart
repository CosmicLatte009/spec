import 'package:flutter/material.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import '../../widget/avatar/user_avatar.dart';
import '../../widget/talk/talk_bubble.dart';
import '../../widget/talk/comment_talk_builder.dart';

class TalkDetailPage extends StatelessWidget {
  const TalkDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
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
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: NavMenu(
                title: '핫한 톡',
                titleDirection: TitleDirection.center,
              ),
            ),
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
                    type: BubbleType.detail,
                    commentCount: 9,
                    upCount: 3,
                    mytalk: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: EdgeInsets.only(top: 14, bottom: 16),
              color: AppColor.white,
              child: Column(
                children: [
                  const NavMenu(
                    title: '이어달린 톡',
                    titleDirection: TitleDirection.left,
                    withEmoji: true,
                    withIconButton: false,
                    emoji: 'assets/icons/pngs/speaker.png',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CommentTalkBuilder(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(10.0),
        height: 70,
        decoration: BoxDecoration(
            color: AppColor.white,
            border: Border(
                top: BorderSide(
              color: AppColor.back05,
              width: 2,
            ))),
        child: CustomInput(
          type: InputType.comment,
        ),
      ),
    );
  }
}
