// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../avatar/user_avatar.dart';
import 'talk_bubble.dart';

class TalkBubbleBuilder extends StatelessWidget {
  const TalkBubbleBuilder(
      {super.key,
      this.userAvatar,
      required this.shortName,
      required this.nickName,
      required this.contents,
      this.commentCount,
      this.upCount,
      required this.isLikePressed,
      this.isMytalk});

  final String? userAvatar;
  final String shortName;
  final String nickName;
  final String contents;
  final int? commentCount;
  final int? upCount;
  final bool isLikePressed;
  final bool? isMytalk;
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
              avatarSvg: userAvatar,
              direction: BadgeDirection.column,
              shortName: shortName,
              nickName: nickName,
            ),
            SizedBox(width: 17.02),
            TalkBubble(
              text: contents,
              isLikePressed: isLikePressed,
              type: BubbleType.less,
              commentCount: commentCount ?? 0,
              upCount: upCount ?? 0,
              mytalk: isMytalk ?? false,
            ),
          ],
        );
      },
    );
  }
}
