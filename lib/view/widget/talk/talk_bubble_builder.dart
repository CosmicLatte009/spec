// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/talk.dart';
import '../avatar/user_avatar.dart';
import 'talk_bubble.dart';

class TalkBubbleBuilder extends StatelessWidget {
  const TalkBubbleBuilder({
    super.key,
    required this.talkDataList,
  });

  final RxList<Talk> talkDataList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: ScrollController(),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: talkDataList.length,
      separatorBuilder: (BuildContext context, int index) {
        if (index == talkDataList.length) return const SizedBox.shrink();
        return const SizedBox(height: 16.0);
      },
      itemBuilder: (BuildContext context, int index) {
        var talk = talkDataList[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(
              avatarUrl: talk.author.avatar,
              direction: BadgeDirection.column,
              shortName: talk.author.badge?.shortName,
              nickName: talk.author.nickname,
            ),
            SizedBox(width: 17.02),
            TalkBubble(
              text: talk.content,
              isLikePressed: true,
              type: BubbleType.less,
              commentCount: talk.childrenLength,
              upCount: (talk.upProfiles?.isEmpty ?? true)
                  ? 0
                  : talk.upProfiles!.length,
              mytalk: false,
              talkId: talk.id,
            ),
          ],
        );
      },
    );
  }
}
