import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spec/model/detail_mogak.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/avatar/atavar_with_role.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class DetailMogakCard extends StatelessWidget {
  const DetailMogakCard({
    super.key,
    required this.mogak,
  });
  final DetailMogak mogak;

  @override
  Widget build(BuildContext context) {
    List<String?> tags =
        mogak.hashtag != null ? mogak.hashtag!.split('#').skip(1).toList() : [];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // user
                Row(
                  children: [
                    // @todo author Id로 유저정보 받아와야 할 듯.
                    //https://dev.sniperfactory.com/api/profile/$authorId
                    // Text(mogak.authorId[0]),
                    const AvatarWithRole(),
                    // mogak.author.avatar != null
                    //     ? Text(mogak.author.avatar.toString())
                    //     : const AvatarWithRole(),
                    // const SizedBox(width: 8),
                    // Text(
                    //   mogak.author.nickname,
                    //   style: AppTextStyles.body12B(),
                    // ),
                    const SizedBox(width: 8),
                    CustomButton(
                      text: '수료생',
                      height: 22,
                      type: ButtonType.neutral,
                    ),
                  ],
                ),
                SvgPicture.asset(
                  'assets/icons/svgs/Like.svg',
                  width: 20,
                  height: 20,
                  color: AppColor.black10, //@todo click시 red
                ),
              ],
            ),
            const SizedBox(height: 16),
            //@todo 모집중 등의 상태? [모집중] <= 이거
            Text(
              mogak.title,
              textAlign: TextAlign.start,
              style: AppTextStyles.body16B(),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              mogak.content,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: tags
                        .map(
                          (tag) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CustomButton(
                              text: '#$tag',
                              height: 22,
                              type: ButtonType.neutral,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Text(
                  DateFormat("yyyy. MM. dd").format(
                    DateTime.parse(mogak.createdAt),
                  ),
                  style: AppTextStyles.body12R(
                    color: AppColor.black40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Image.asset(
                  'assets/icons/pngs/man-who.png',
                  width: 25,
                  height: 25,
                ),
                const SizedBox(width: 6),
                Text(
                  mogak.appliedProfiles.length.toString(),
                  style: AppTextStyles.body12B(
                    color: AppColor.primary,
                  ),
                ),
                Text(
                  '/${mogak.maxMember} 참여',
                  style: AppTextStyles.body12R(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
