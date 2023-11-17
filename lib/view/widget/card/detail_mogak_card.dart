import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:spec/model/mogak/detail_mogak.dart';
import 'package:spec/model/user/profile.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/alert/300_width/with_two_button.dart';
import 'package:spec/view/widget/alert/300_width_description/description_with_two_button.dart';
import 'package:spec/view/widget/avatar/join_avatars.dart';
import 'package:spec/view/widget/avatar/user_avatar.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class DetailMogakCard extends StatelessWidget {
  const DetailMogakCard({
    super.key,
    required this.mogak,
    this.controller,
    required this.mogakState,
    this.isLiked = false,
    required this.isUped,
    required this.isJoined,
    required this.userInfo,
    this.inVisibleButton,
  });
  final DetailMogak mogak;
  final String mogakState;
  final controller;
  final bool isLiked;
  final bool isUped;
  final bool isJoined;
  final Profile userInfo;
  final bool? inVisibleButton;

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
                if (controller.userInfo != null)
                  UserAvatar(
                    avatarUrl: userInfo.avatar,
                    avatarSize: AvatarSize.w40,
                    direction: BadgeDirection.row,
                    nickName: userInfo.nickname,
                    nickNameSize: AppTextStyles.body12B(),
                    // @todo badgeId가 들어옴. badge가 없음.
                    // role: appliedProfiles.role,
                    // shortName:
                  ),
                GestureDetector(
                  onTap: controller.toggleLike,
                  child: SvgPicture.asset(
                    'assets/icons/svgs/Like.svg',
                    width: 20,
                    height: 20,
                    color: isLiked ? AppColor.warning : AppColor.black10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '[$mogakState] ',
                    style: AppTextStyles.body16B(
                      color: AppColor.primary,
                    ),
                  ),
                  TextSpan(
                    text: mogak.title,
                    style: AppTextStyles.body16B(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              mogak.content,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    children: tags
                        .map(
                          (tag) => IntrinsicWidth(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                              child: CustomButton(
                                text: '#$tag',
                                height: 22,
                                type: ButtonType.neutral,
                              ),
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
            const SizedBox(height: 8),
            //appliedProfiles
            SizedBox(
              height: 95,
              child: JoinAvatars(
                appliedProfiles: mogak.appliedProfiles,
              ),
            ),
            const SizedBox(height: 30),
            inVisibleButton == true
                ? Container()
                : CustomButton(
                    text: isJoined == true ? '탈퇴하기' : '참여하기',
                    height: 56,
                    onTap: () {
                      isJoined == true
                          ? showDialog(
                              context: context,
                              builder: (context) {
                                return DescriptionWithTwoButton(
                                  mainMessage: '참여중인 그룹에서 탈퇴하시겠습니까?',
                                  subMessage: '탈퇴한 그룹에서 다시 참여가 가능합니다.',
                                  buttonTitle1: '취소하기',
                                  buttonTitle2: '탈퇴하기',
                                  callback2: controller.cancelJoin,
                                );
                              })
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return WithTwoButton(
                                  button1: '취소하기',
                                  button2: '참여하기',
                                  message: '그룹에 참여하시겠습니까?',
                                  callback2: controller.joinMogak,
                                );
                              },
                            );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
