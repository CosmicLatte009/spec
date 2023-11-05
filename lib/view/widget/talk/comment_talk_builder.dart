import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../model/talk.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../../util/time_utils.dart';
import '../alert/300_width_description/description_with_two_button.dart';
import '../avatar/user_avatar.dart';
import '../button/button_circle.dart';
import '../popup/popup.dart';

class CommentTalkBuilder extends StatefulWidget {
  const CommentTalkBuilder({
    super.key,
    required this.data,
    this.myComment = false,
    this.isLikePressed = false,
    this.withLikebutton = true,
  });

  final List<Talk> data;
  final bool myComment;
  final bool isLikePressed;
  final bool withLikebutton;

  @override
  State<CommentTalkBuilder> createState() => _CommentTalkBuilderState();
}

class _CommentTalkBuilderState extends State<CommentTalkBuilder> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Text(
            '아직 이어달린 톡이 없습니다.',
            style: AppTextStyles.body14M(color: AppColor.black60),
          ),
        ),
      );
    }
    return ListView.separated(
      controller: ScrollController(),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.data.length,
      separatorBuilder: (BuildContext context, int index) {
        if (index > widget.data.length - 1) {
          return const SizedBox.shrink();
        } else {
          return const SizedBox(height: 8.0);
        }
      },
      itemBuilder: (BuildContext context, int index) {
        var comment = widget.data[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(
              avatarUrl: comment.author.avatar,
              direction: BadgeDirection.row,
              shortName: comment.author.badge?.shortName,
              nickName: comment.author.nickname,
              role: comment.author.role,
            ),
            const SizedBox(height: 15),
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onLongPress: widget.myComment
                          ? () {
                              setState(() {
                                isPressed = !isPressed;
                              });
                            }
                          : null,
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(minHeight: 65),
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 16),
                        decoration: BoxDecoration(
                          color: isPressed == true
                              ? AppColor.primary05
                              : AppColor.black05,
                          borderRadius: BorderRadius.circular(10),
                          border: isPressed == true
                              ? Border.all(color: AppColor.primary40, width: 1)
                              : null,
                        ),
                        child: Text(
                          comment.content,
                          style: AppTextStyles.body14M(),
                        ),
                      ),
                    ),
                    if (isPressed)
                      Positioned(
                        top: -63,
                        right: 102,
                        child: Row(
                          children: [
                            CircleButton(
                                svg: 'assets/icons/svgs/editable.svg',
                                onTap: () {
                                  setState(
                                    () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Popup(
                                              isWide: true,
                                              child: Material(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16,
                                                      vertical: 24),
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(),
                                                    minLines: 10,
                                                    maxLines: 10,
                                                    style:
                                                        AppTextStyles.body14R(),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        vertical: 8,
                                                      ),
                                                      border: InputBorder.none,
                                                      hintText: '내용을 입력해주세요.',
                                                      hintStyle:
                                                          AppTextStyles.body14R(
                                                        color: AppColor.black20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                  );
                                }),
                            const SizedBox(width: 8),
                            CircleButton(
                                svg: 'assets/icons/svgs/Delete_float.svg',
                                onTap: () {
                                  setState(
                                    () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const DescriptionWithTwoButton(
                                              mainMessage: '내 톡을 삭제하시겠습니까?',
                                              subMessage: '한번 삭제하면 복구가 불가능합니다.',
                                              buttonTitle1: '취소하기',
                                              buttonTitle2: '삭제하기',
                                            );
                                          });
                                    },
                                  );
                                }),
                          ],
                        ),
                      ),
                    if (widget.withLikebutton)
                      Positioned(
                        top: -15,
                        right: 5,
                        child: CircleButton(
                          svg: widget.isLikePressed
                              ? 'assets/icons/svgs/Like.svg '
                              : 'assets/icons/svgs/NotSelect.svg',
                          iconWidth: 16.0,
                          buttonWidth: 20,
                          onTap: () {},
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      TimeUtils.relativeTime(comment.createdAt),
                      style: AppTextStyles.body12R(color: AppColor.black40),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/svgs/Like.svg',
                          width: 12.8,
                        ),
                        Text(
                          '${comment.upProfiles?.length ?? 0}',
                          style:
                              AppTextStyles.body12R(color: AppColor.primary80),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
