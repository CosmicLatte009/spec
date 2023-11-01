import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spec/model/mogak.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/avatar/default_circle_avatar.dart';
import 'package:spec/view/widget/avatar/mini_avatars.dart';

class CardSeperator extends StatelessWidget {
  const CardSeperator({
    super.key,
    required this.mogak,
  });
  final Mogak mogak;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (mogak.appliedProfiles != [])
              Row(
                children: [
                  MiniAvatars(
                    number: mogak.appliedProfiles.length,
                    child: const DefaultCircleAvatar(
                      radius: 10,
                      imageRadius: 14,
                    ),
                  ),
                  const SizedBox(width: 2),
                  SvgPicture.asset(
                    'assets/icons/svgs/plus.svg',
                    width: 16,
                    height: 16,
                  ),
                  Text(
                    //@todo 이게 아니라 댓글수인것같음. 단일 모각에서 talks.length 받아오기
                    mogak.appliedProfiles.length.toString(),
                    style: AppTextStyles.body12R(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            if (mogak.up != null)
              Row(
                children: [
                  MiniAvatars(
                    number: mogak.up!,
                    child: const DefaultCircleAvatar(
                      radius: 10,
                      imageRadius: 14,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/svgs/Like.svg',
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    mogak.up.toString(),
                    style: AppTextStyles.body12R(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
