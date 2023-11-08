import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controller/talk/talk_editing_controller.dart';
import '../../../model/talk.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../../util/time_utils.dart';
import '../alert/300_width_icon/icon_text_with_one_button.dart';
import '../avatar/user_avatar.dart';
import '../button/button_circle.dart';

class CommentTalk extends StatefulWidget {
  final Talk comment;
  final bool myComment;
  final bool withLikeButton;
  final Function? onTalkUpdated;

  const CommentTalk({
    Key? key,
    required this.comment,
    this.myComment = false,
    this.withLikeButton = true,
    this.onTalkUpdated,
  }) : super(key: key);

  @override
  _CommentTalkState createState() => _CommentTalkState();
}

class _CommentTalkState extends State<CommentTalk> {
  bool isPressed = false;
  bool isLikePressed = false;
  TextEditingController textEditingController = TextEditingController();
  TalkEditingController talkEditingController =
      Get.find<TalkEditingController>();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(
              avatarUrl: widget.comment.author.avatar,
              direction: BadgeDirection.row,
              shortName: widget.comment.author.badge?.shortName,
              nickName: widget.comment.author.nickname,
              role: widget.comment.author.role,
            ),
            const SizedBox(height: 15),
            Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onLongPress: widget.myComment
                      ? () {
                          if (widget.comment.isDeleted) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return IconTextWithOneButton(
                                  svgPath: 'assets/icons/svgs/Warning.svg',
                                  mainMessage: '이미 삭제된 톡입니다!',
                                  subMessage: '클릭하신 톡을 찾을 수 없습니다.',
                                  buttonTitle: '닫기',
                                  onTap: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      isPressed = false;
                                    });
                                  },
                                );
                              },
                            );
                          } else {
                            setState(() {
                              isPressed = !isPressed;
                            });
                          }
                        }
                      : null,
                  // onLongPress: widget.myComment
                  //     ? () {
                  //         setState(() {
                  //           isPressed = !isPressed;
                  //         });
                  //       }
                  //     : null,
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 65),
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isPressed ? AppColor.primary05 : AppColor.black05,
                      borderRadius: BorderRadius.circular(10),
                      border: isPressed
                          ? Border.all(color: AppColor.primary40, width: 1)
                          : null,
                    ),
                    child: Text(
                      widget.comment.content,
                      style: AppTextStyles.body14M(),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                _buildCommentInfo(),
              ],
            ),
          ],
        ),
        if (isPressed)
          Positioned(
            top: 17,
            left: 213,
            child: _buildEditingActions(),
          ),
        if (widget.withLikeButton)
          Positioned(
            top: 60,
            right: 5,
            child: Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleButton(
                  svg: isLikePressed
                      ? 'assets/icons/svgs/Like.svg'
                      : 'assets/icons/svgs/NotSelect.svg',
                  iconWidth: 16.0,
                  buttonWidth: 20,
                  onTap: _handleLikePressed,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEditingActions() {
    return Container(
      color: Colors.red,
      child: Row(
        children: [
          CircleButton(
              svg: 'assets/icons/svgs/editable.svg',
              onTap: () {
                print(widget.comment.id);
                talkEditingController.updateTalkInPopup(
                    context, textEditingController, widget.comment.id,
                    afterUpdateSuccess: () {
                  widget.onTalkUpdated!();
                });
                print('수정팝업');
              }),
          const SizedBox(width: 8),
          CircleButton(
              svg: 'assets/icons/svgs/Delete_Float.svg',
              onTap: () {
                talkEditingController.deleteTalkInPopup(
                  context,
                  widget.comment.id,
                  afterDeleteSuccess: () {
                    widget.onTalkUpdated!();
                  },
                );
                print('삭제팝업');
              }),
        ],
      ),
    );
  }

  Widget _buildCommentInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          TimeUtils.relativeTime(widget.comment.updatedAt),
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
              '${widget.comment.upProfiles?.length ?? 0}',
              style: AppTextStyles.body12R(color: AppColor.primary80),
            )
          ],
        )
      ],
    );
  }

  void _handleLikePressed() {
    setState(() {
      print('하트 눌려야해');
      isLikePressed = !isLikePressed;
      // widget.onTalkUpdated?.call();
    });
  }
}
