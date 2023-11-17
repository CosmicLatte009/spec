import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spec/model/user/author.dart';
import 'package:spec/util/app_page_routes.dart';
import '../../../controller/talk/talk_controller.dart';
import '../../../controller/talk/talk_editing_controller.dart';
import '../../../model/talk/talk.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../../util/time_utils.dart';
import '../alert/300_width_icon/icon_text_with_one_button.dart';
import '../avatar/user_avatar.dart';
import '../button/button_circle.dart';

class MyCommentTalk extends StatefulWidget {
  final Talk comment;
  final Talk? parentTalk;
  final Function? onTalkUpdated;

  const MyCommentTalk({
    Key? key,
    required this.comment,
    this.parentTalk,
    this.onTalkUpdated,
  }) : super(key: key);

  @override
  _MyCommentTalkState createState() => _MyCommentTalkState();
}

class _MyCommentTalkState extends State<MyCommentTalk> {
  var talkController = Get.find<TalkController>();
  TalkEditingController talkEditingController =
      Get.find<TalkEditingController>();

  bool isLoading = true;
  bool isMyTalk = false;
  bool isPressed = false;
  TextEditingController textEditingController = TextEditingController();
  Author? parentTalksAuthor;

  @override
  void initState() {
    super.initState();
    isMyTalk = talkController.isMyTalk(widget.comment.authorId);
    parentTalksAuthor = widget.parentTalk?.author;
  }

  // loadParentTalksAuthor() async {
  //   try {
  //     if (widget.comment.parentId != null) {
  //       var author = await talkController
  //           .getAuthorOfParentTalk(widget.comment.parentId!);
  //       setState(() {
  //         parentTalksAuthor = author;
  //       });
  //     }
  //   } catch (e) {
  //     isLoading = false;
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (widget.comment.parentId != null) {
                  Get.toNamed(
                    AppPagesRoutes.detailTalk,
                    parameters: {'id': widget.comment.parentId!},
                  );
                }
              },
              child: Row(
                children: [
                  UserAvatar(
                    avatarUrl: parentTalksAuthor?.avatar,
                    direction: BadgeDirection.row,
                    shortName: parentTalksAuthor?.badge?.shortName,
                    nickName: parentTalksAuthor?.nickname ?? 'Unknown',
                    role: parentTalksAuthor?.role ?? 'role',
                  ),
                  const SizedBox(width: 6.36),
                  Expanded(
                    child: Text(
                      '님의 톡에 댓글을 남겼습니다.',
                      style: AppTextStyles.body14R(color: AppColor.black80),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SvgPicture.asset('assets/icons/svgs/Right.svg')
                ],
              ),
            ),
            const SizedBox(height: 15),
            Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onLongPress: () {
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
                    } else if (isMyTalk) {
                      setState(() {
                        isPressed = !isPressed;
                      });
                    }
                  },
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
                _buildCommentInfo(widget.comment),
              ],
            ),
          ],
        ),
        if (isPressed)
          Positioned(
            top: 17,
            left: 213,
            child: _buildEditingActions(widget.comment.id),
          ),
        if (!isMyTalk)
          Obx(() {
            bool isLikePressed = talkController.isTalkLiked(widget.comment.id);
            return Positioned(
              top: 52,
              right: 0,
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
            );
          }),
      ],
    );
  }

  Widget _buildEditingActions(String commentTalkId) {
    return Row(
      children: [
        CircleButton(
            svg: 'assets/icons/svgs/editable.svg',
            onTap: () {
              print(commentTalkId);
              talkEditingController.updateTalkInPopup(
                context,
                textEditingController,
                commentTalkId,
                afterUpdateSuccess: () {
                  widget.onTalkUpdated?.call();
                  setState(() {
                    isPressed = false;
                  });
                },
              );
            }),
        const SizedBox(width: 8),
        CircleButton(
            svg: 'assets/icons/svgs/Delete_Float.svg',
            onTap: () {
              print(commentTalkId);
              talkEditingController.deleteTalkInPopup(
                context,
                commentTalkId,
                afterDeleteSuccess: () {
                  widget.onTalkUpdated?.call();
                  setState(() {
                    isPressed = false;
                  });
                },
              );
            }),
      ],
    );
  }

  Widget _buildCommentInfo(Talk comment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          TimeUtils.relativeTime(comment.updatedAt),
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
              style: AppTextStyles.body12R(color: AppColor.primary80),
            )
          ],
        )
      ],
    );
  }

  void _handleLikePressed() async {
    await talkController.toggleLike(widget.comment.id);
  }
}
