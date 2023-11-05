import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/util/time_utils.dart';
import 'package:spec/view/widget/avatar/stack_avatars.dart';
import 'package:spec/view/widget/popup/talk_editing_popup.dart';
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
    required this.isLikePressed,
    this.onTapEnabled = true,
  });
  final Talk? talk;
  final bool mytalk;
  final BubbleType type;
  final bool isLikePressed;
  final bool onTapEnabled;
  @override
  State<TalkBubble> createState() => _TalkBubbleState();
}

class _TalkBubbleState extends State<TalkBubble> {
  bool isPressed = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onLongPress: widget.mytalk
            ? () {
                setState(() {
                  isPressed = !isPressed;
                });
              }
            : null,
        onTap: widget.onTapEnabled && widget.talk != null
            ? () {
                Get.toNamed(AppPagesRoutes.detailTalk,
                    parameters: {'id': widget.talk!.id});
              }
            : null,
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
                                  widget.talk?.createdAt != null
                                      ? TimeUtils.relativeTime(
                                          widget.talk!.createdAt)
                                      : '날짜 정보 없음',
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
                          SvgPicture.asset(
                            widget.isLikePressed
                                ? 'assets/icons/svgs/Like.svg'
                                : 'assets/icons/svgs/NotSelect.svg',
                            width: 20,
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
                                setState(
                                  () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return TalkEditingPopup(
                                            controller:
                                                textEditingController, //@todo: 톡 수정하기 위해서 글자 나타나도록 하기
                                            onSubmit: () {
                                              print(textEditingController
                                                  .text); //@todo: controller로부터 고유 톡id로 put 수정하는 함수 호출;
                                            },
                                          );
                                        });
                                  },
                                );
                              },
                            ),
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
