import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/util/time_utils.dart';
import 'package:spec/view/widget/alert/300_width_icon/icon_text_with_one_button.dart';
import 'package:spec/view/widget/avatar/stack_avatars.dart';
import '../../../controller/talk/talk_controller.dart';
import '../../../controller/talk/talk_editing_controller.dart';
import '../../../model/talk.dart';
import '../../../util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import '../button/button_circle.dart';

enum BubbleType { less, detail, myTalkEdit }

class TalkBubble extends StatefulWidget {
  const TalkBubble({
    Key? key,
    required this.talk,
    this.type = BubbleType.less,
    this.onTapEnabled = true,
    this.onTalkUpdated,
  }) : super(key: key);
  final Talk? talk;
  final BubbleType type;
  final bool onTapEnabled;
  final Function? onTalkUpdated;

  @override
  State<TalkBubble> createState() => _TalkBubbleState();
}

class _TalkBubbleState extends State<TalkBubble> {
  var talkController = Get.find<TalkController>();
  var talkEditingController = Get.find<TalkEditingController>();

  bool isMyTalk = false;
  bool isPressed = false;
  bool isLikePressed = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLikeStatus();
    isMyTalk = talkController.isMyTalk(widget.talk!.authorId);
  }

  void checkLikeStatus() async {
    bool liked = await talkController.checkIfUserLikedTalk(widget.talk!.id);

    setState(() {
      isLikePressed = liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    String talkId = widget.talk!.id;

    Widget buildColumnWithBubbleAndAvatars() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onLongPress: () {
              if (widget.talk!.isDeleted) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return IconTextWithOneButton(
                      svgPath: 'assets/icons/sgvs/Warning.svg',
                      mainMessage: '이미 삭제된 톡입니다!',
                      subMessage: '클릭하신 톡을 찾을 수 없습니다.',
                      buttonTitle: '닫기',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              } else if (widget.type == BubbleType.myTalkEdit) {
                return;
              } else if (isMyTalk) {
                setState(() {
                  isPressed = !isPressed;
                });
              }
            },
            onTap: () {
              if (widget.talk!.isDeleted) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return IconTextWithOneButton(
                      svgPath: 'assets/icons/sgvs/Warning.svg',
                      mainMessage: '이미 삭제된 톡입니다!',
                      subMessage: '클릭하신 톡을 찾을 수 없습니다.',
                      buttonTitle: '닫기',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              } else if (widget.onTapEnabled && widget.talk != null) {
                Get.toNamed(AppPagesRoutes.detailTalk,
                    parameters: {'id': widget.talk!.id});
              }
            },
            child: Bubble(
              padding: const BubbleEdges.fromLTRB(28, 16, 12, 16),
              nip: widget.type == BubbleType.less ||
                      widget.type == BubbleType.myTalkEdit
                  ? BubbleNip.leftBottom
                  : BubbleNip.leftCenter,
              nipRadius: 2.0,
              radius: const Radius.circular(6.0),
              borderColor: isPressed ? AppColor.primary40 : AppColor.black10,
              color: isPressed ? AppColor.primary05 : AppColor.white,
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: widget.type == BubbleType.less ||
                        widget.type == BubbleType.myTalkEdit
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TimeUtils.relativeTime(widget.talk!.updatedAt),
                          style: AppTextStyles.body12R(color: AppColor.black40),
                        ),
                        const SizedBox(height: 4),
                        if (widget.type == BubbleType.less ||
                            widget.type == BubbleType.myTalkEdit)
                          Text(
                            widget.talk?.content ?? '',
                            style:
                                AppTextStyles.body14M(color: AppColor.black80),
                            overflow: TextOverflow.ellipsis,
                          )
                        else
                          Container(
                            constraints: BoxConstraints(
                                minWidth: 200, maxWidth: double.infinity),
                            child: Text(
                              widget.talk?.content ?? '',
                              style: AppTextStyles.body14M(
                                  color: AppColor.black80),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (!isMyTalk)
                    InkWell(
                      onTap: _handleLikePressed,
                      child: SvgPicture.asset(
                        isLikePressed
                            ? 'assets/icons/svgs/Like.svg'
                            : 'assets/icons/svgs/NotSelect.svg',
                        width: 20,
                      ),
                    ),
                  if (widget.type == BubbleType.myTalkEdit)
                    SvgPicture.asset(
                      'assets/icons/svgs/....svg',
                      width: 20,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 3),
          StackAvatars(
            commentLength: widget.talk?.childrenLength ?? 0,
            upLength: widget.talk?.upProfiles?.length ?? 0,
          ),
        ],
      );
    }

    Widget buildButtons(String talkId) {
      if (isMyTalk || widget.type == BubbleType.myTalkEdit) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleButton(
              svg: 'assets/icons/svgs/editable.svg',
              onTap: () {
                talkEditingController
                    .updateTalkInPopup(context, textEditingController, talkId,
                        afterUpdateSuccess: () {
                  widget.onTalkUpdated!();
                });
              },
            ),
            const SizedBox(width: 8),
            CircleButton(
              svg: 'assets/icons/svgs/Delete_Float.svg',
              onTap: () {
                talkEditingController.deleteTalkInPopup(
                  context,
                  talkId,
                  afterDeleteSuccess: () {
                    widget.onTalkUpdated!();
                  },
                );
              },
            ),
          ],
        );
      } else {
        return Container();
      }
    }

    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              if (widget.type == BubbleType.myTalkEdit)
                Container(
                  width: 307,
                  child: buildColumnWithBubbleAndAvatars(),
                ),
              if (widget.type != BubbleType.myTalkEdit)
                buildColumnWithBubbleAndAvatars(),
            ],
          ),
          if (isPressed || widget.type == BubbleType.myTalkEdit)
            Positioned(
              top: widget.type != BubbleType.myTalkEdit ? -15 : 17,
              right: widget.type != BubbleType.myTalkEdit ? -5 : 10,
              child: buildButtons(talkId),
            ),
        ],
      ),
    );
  }

  void _handleLikePressed() async {
    bool newLikeStatus = await talkController.toggleLike(widget.talk!.id);
    if (newLikeStatus != isLikePressed) {
      setState(() {
        isLikePressed = newLikeStatus;
      });
      widget.onTalkUpdated!();
    }
  }
}
