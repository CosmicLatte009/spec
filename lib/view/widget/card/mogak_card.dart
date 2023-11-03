import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spec/controller/like_controller.dart';
import 'package:spec/model/mogak.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/avatar/user_avatar.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class MogakCard extends StatelessWidget {
  const MogakCard({
    super.key,
    required this.mogak,
    required this.mogakState,
  });
  final Mogak mogak;
  final String mogakState;

  @override
  Widget build(BuildContext context) {
    var likeController = Get.find<LikeController>();

    List<String> tags =
        mogak.hashtag != null ? mogak.hashtag!.split('#').skip(1).toList() : [];

    return GestureDetector(
      onTap: () {
        Get.toNamed('/mogak/${mogak.id}');
      },
      child: Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // user
                  UserAvatar(
                    avatarUrl: mogak.author.avatar,
                    avatarSize: AvatarSize.w40,
                    direction: BadgeDirection.row,
                    shortName: mogak.author.badge != null
                        ? mogak.author.badge!.shortName
                        : null,
                    nickName: mogak.author.nickname,
                    nickNameSize: AppTextStyles.body12B(),
                    role: mogak.appliedProfiles[0].role == 'NEWBIE'
                        ? '수료생'
                        : null, //@todo 수료생 뱃지 어디있는지?
                  ),
                  GestureDetector(
                    onTap: () {
                      likeController.likeUp(
                        key: LikeType.mogakId,
                        id: mogak.id,
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/icons/svgs/Like.svg',
                      width: 20,
                      height: 20,
                      color: likeController.isLiked
                          ? AppColor.warning
                          : AppColor.black10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    '[$mogakState] ',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.body16B(
                      color: AppColor.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Flexible(
                    child: Text(
                      mogak.title,
                      textAlign: TextAlign.start,
                      style: AppTextStyles.body16B(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                mogak.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
              const SizedBox(height: 10),
              Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
