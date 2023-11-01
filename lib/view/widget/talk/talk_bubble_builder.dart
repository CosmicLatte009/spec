import 'package:flutter/material.dart';
import '../avatar/user_avatar.dart';
import 'talk_bubble.dart';

class TalkBubbleBuilder extends StatelessWidget {
  const TalkBubbleBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: ScrollController(),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) {
        if (index == 9) return const SizedBox.shrink();

        return const SizedBox(height: 16.0);
      },
      itemBuilder: (BuildContext context, int index) {
        return Row(
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
              text: '근데 15일차 강의 푸신 분 계신가요? 저는 아직 잘 모르겠습니다...혹시 도움 주실 분 계실까요???',
              isLikePressed: true,
              type: BubbleType.less,
              commentCount: 9,
              upCount: 3,
              mytalk: true,
            ),
          ],
        );
      },
    );
  }
}
