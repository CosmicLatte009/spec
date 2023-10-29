import 'package:flutter/material.dart';
import 'package:spec/model/mogak.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/avatar/default_avatar.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class MogakCard extends StatelessWidget {
  const MogakCard({
    super.key,
    required this.mogak,
  });
  final Mogak mogak;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColor.black10,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                mogak.author.avatar != null
                    ? Text(mogak.author.avatar.toString())
                    : Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColor.back05,
                            child: DefaultAvatar(
                              width: 27,
                              hairPosition: -5,
                            ),
                          ),
                          Positioned(
                            bottom: -6,
                            child: CustomButton(
                              text: '개발자/1기', //@todo role + '1기'?
                              height: 12,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(width: 8),
                Text(
                  mogak.author.nickname,
                  style: AppTextStyles.body12B(),
                ),
                const SizedBox(width: 8),
                CustomButton(
                  text: '수료생',
                  height: 22,
                  type: ButtonType.neutral,
                ),
              ],
            ),
            const SizedBox(height: 16),
            //@todo 모집중 등의 상태?
            Text(
              mogak.title,
              textAlign: TextAlign.start,
              style: AppTextStyles.body16B(),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(mogak.content), //@todo 2줄까지만 나오도록 함. ellipsis
            const SizedBox(height: 12),
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
            Text(mogak.createdAt), //@todo 날짜 형식 포매터 찾아보기
            if (mogak.hashtag != null)
              Text(mogak.hashtag.toString()), //@todo #를 기준으로 slice해서 tag 만들기
          ],
        ),
      ),
    );
  }
}
