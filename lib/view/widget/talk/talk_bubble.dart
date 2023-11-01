import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spec/view/widget/avatar/stack_avatars.dart';
import 'package:spec/view/widget/popup/popup.dart';
import '../../../util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import '../alert/300_width_description/description_with_two_button.dart';
import '../button/button_circle.dart';

enum BubbleType { less, detail }

class TalkBubble extends StatefulWidget {
  const TalkBubble({
    super.key,
    required this.text,
    this.type = BubbleType.less,
    required this.isLikePressed,
    required this.commentCount,
    required this.upCount,
    this.mytalk = false,
  });

  final String text;
  final BubbleType type;
  final bool isLikePressed;
  final int commentCount;
  final int upCount;
  final bool mytalk;

  @override
  State<TalkBubble> createState() => _TalkBubbleState();
}

class _TalkBubbleState extends State<TalkBubble> {
  bool isPressed = false;

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
                                  '24분 전',
                                  style: AppTextStyles.body12R(
                                      color: AppColor.black40),
                                ),
                                const SizedBox(height: 4),
                                if (widget.type == BubbleType.less)
                                  Text(
                                    widget.text,
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
                                      widget.text,
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
                  ],
                ),
                const SizedBox(height: 3),
                StackAvatars(
                  commentLength: widget.commentCount,
                  upLength: widget.upCount,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
