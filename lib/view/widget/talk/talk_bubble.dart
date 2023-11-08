import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/util/time_utils.dart';
import 'package:spec/view/widget/alert/300_width_description/description_with_one_button.dart';
import 'package:spec/view/widget/alert/300_width_icon/icon_text_with_one_button.dart';
import 'package:spec/view/widget/avatar/stack_avatars.dart';
import 'package:spec/view/widget/popup/talk_editing_popup.dart';
import '../../../controller/talk/talk_controller.dart';
import '../../../controller/talk/talk_editing_controller.dart';
import '../../../model/talk.dart';
import '../../../util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import '../alert/300_width_description/description_with_two_button.dart';
import '../button/button_circle.dart';

enum BubbleType { less, detail }

class TalkBubble extends StatefulWidget {
  const TalkBubble({
    super.key,
    required this.talk,
    this.mytalk = false,
    this.type = BubbleType.less,
    // required this.isLikePressed,
    this.onTapEnabled = true,
    this.onTalkUpdated,
  });
  final Talk? talk;
  final bool mytalk;
  final BubbleType type;
  // final bool isLikePressed;
  final bool onTapEnabled;
  final Function? onTalkUpdated;

  @override
  State<TalkBubble> createState() => _TalkBubbleState();
}

class _TalkBubbleState extends State<TalkBubble> {
  var talkEditingController = Get.find<TalkEditingController>();

  bool isPressed = false;
  late bool isLiked = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String talkId = widget.talk!.id;
    return Expanded(
      child: GestureDetector(
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
          } else if (widget.mytalk) {
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
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Bubble(
                      padding: const BubbleEdges.fromLTRB(28, 16, 12, 16),
                      nip: widget.type == BubbleType.less
                          ? BubbleNip.leftBottom
                          : BubbleNip.leftCenter,
                      nipRadius: 2.0,
                      radius: const Radius.circular(6.0),
                      borderColor:
                          isPressed ? AppColor.primary40 : AppColor.black10,
                      color: isPressed ? AppColor.primary05 : AppColor.white,
                      elevation: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: widget.type == BubbleType.less
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  TimeUtils.relativeTime(
                                      widget.talk!.updatedAt),
                                  style: AppTextStyles.body12R(
                                      color: AppColor.black40),
                                ),
                                const SizedBox(height: 4),
                                if (widget.type == BubbleType.less)
                                  Text(
                                    widget.talk?.content ?? '',
                                    style: AppTextStyles.body14M(
                                        color: AppColor.black80),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )
                                else
                                  Container(
                                    constraints: const BoxConstraints(
                                        minWidth: 200,
                                        maxWidth: double.infinity),
                                    child: Text(
                                      widget.talk?.content ?? '내용이 없습니다.',
                                      style: AppTextStyles.body14M(
                                          color: AppColor.black80),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print('좋아요좋아');
                            },
                            // onTap: () async {
                            //   bool newLikeStatus = await talkEditingController
                            //       .toggleLike(talkId);
                            //   setState(() {
                            //     isLiked = newLikeStatus;
                            //   });
                            //   // 부모 위젯에 업데이트를 알립니다.
                            //   widget.onTalkUpdated?.call();
                            // },
                            child: SvgPicture.asset(
                              isLiked
                                  ? 'assets/icons/svgs/Like.svg'
                                  : 'assets/icons/svgs/NotSelect.svg',
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isPressed)
                      Positioned(
                        top: -15,
                        right: 5,
                        child: Row(
                          children: [
                            CircleButton(
                              svg: 'assets/icons/svgs/editable.svg',
                              onTap: () {
                                talkEditingController.updateTalkInPopup(
                                    context, textEditingController, talkId,
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
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                StackAvatars(
                  commentLength: widget.talk?.childrenLength ?? 0,
                  upLength: widget.talk?.upProfiles?.length ?? 0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
