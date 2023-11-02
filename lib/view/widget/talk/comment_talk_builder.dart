import 'package:flutter/material.dart';
import '../avatar/user_avatar.dart';
import 'comment_talk.dart';

class CommentTalkBuilder extends StatelessWidget {
  const CommentTalkBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: ScrollController(),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 14,
      separatorBuilder: (BuildContext context, int index) {
        if (index == 9) return const SizedBox.shrink();

        return const SizedBox(height: 8.0);
      },
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(
              avatarSvg: 'assets/icons/svgs/man-a.svg',
              direction: BadgeDirection.row,
              shortName: '개발자/1기',
              nickName: '캐서린',
              role: '수료생',
            ),
            const SizedBox(height: 15),
            CommentTalk(
              text: '와 새로운 기능이 정리가 잘되어있네요! 좋은 정보 공유 감사드립니다! 글을 너무 잘 쓰시는 것 같아요!',
              date: '2023.04.05',
              up: 3,
              myComment: true,
            ),
          ],
        );
      },
    );
  }
}
