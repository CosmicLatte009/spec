import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spec/model/mogak.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/avatar/user_avatar.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class MogakCard extends StatefulWidget {
  const MogakCard({
    super.key,
    required this.mogak,
    required this.mogakState,
    required this.isUped,
    this.controller,
    required this.title,
  });
  final Mogak mogak;
  final String mogakState;
  final bool isUped;
  final controller;
  final String title;

  @override
  State<MogakCard> createState() => _MogakCardState();
}

class _MogakCardState extends State<MogakCard> {
  RxBool isLiked = false.obs;

  @override
  void initState() {
    super.initState();
    isLiked.value = widget.isUped;
  }

  @override
  Widget build(BuildContext context) {
    List<String> tags = widget.mogak.hashtag != null
        ? widget.mogak.hashtag!.split('#').skip(1).toList()
        : [];
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          '/mogak/${widget.mogak.id}',
          arguments: {
            "title": widget.title,
          },
        );
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
          padding: const EdgeInsets.fromLTRB(16, 16, 13, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserAvatar(
                    avatarUrl: widget.mogak.author.avatar,
                    avatarSize: AvatarSize.w40,
                    direction: BadgeDirection.row,
                    shortName: widget.mogak.author.badge != null
                        ? widget.mogak.author.badge!.shortName
                        : null,
                    nickName: widget.mogak.author.nickname,
                    nickNameSize: AppTextStyles.body12B(),
                    role: widget.mogak.appliedProfiles[0].role,
                  ),
                  GestureDetector(
                    onTap: () async {
                      isLiked.value = await widget.controller(widget.mogak.id);
                      print(isLiked);
                    },
                    child: Obx(
                      () => SvgPicture.asset(
                        'assets/icons/svgs/Like.svg',
                        width: 20,
                        height: 20,
                        color: isLiked == true
                            ? AppColor.warning
                            : AppColor.black10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    '[${widget.mogakState}] ',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.body16B(
                      color: AppColor.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Flexible(
                    child: Text(
                      widget.mogak.title,
                      textAlign: TextAlign.start,
                      style: AppTextStyles.body16B(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.mogak.content,
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
                        widget.mogak.appliedProfiles.length.toString(),
                        style: AppTextStyles.body12B(
                          color: AppColor.primary,
                        ),
                      ),
                      Text(
                        '/${widget.mogak.maxMember} 참여',
                        style: AppTextStyles.body12R(),
                      ),
                    ],
                  ),
                  Text(
                    DateFormat("yyyy. MM. dd").format(
                      DateTime.parse(widget.mogak.createdAt),
                    ),
                    style: AppTextStyles.body12R(
                      color: AppColor.black40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
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
            ],
          ),
        ),
      ),
    );
  }
}
