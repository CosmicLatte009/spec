import 'package:flutter/material.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/button_small.dart';
import 'package:spec/view/widget/tag/tag.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.titleController,
    required this.contentsController,
    required this.tag1Controller,
    required this.tag2Controller,
    required this.submitAction,
    required this.cancelAction,
    this.tag1,
    this.tag2,
  });
  final TextEditingController titleController;
  final TextEditingController contentsController;
  final TextEditingController tag1Controller;
  final TextEditingController tag2Controller;
  final Function() submitAction;
  final Function() cancelAction;
  final String? tag1;
  final String? tag2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Listener(
          onPointerDown: (_) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColor.black10,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                TextField(
                  style: AppTextStyles.body16B(),
                  controller: titleController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    border: InputBorder.none,
                    hintText: '제목을 입력해주세요.',
                    hintStyle: AppTextStyles.body16M(
                      color: AppColor.black40,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    TextField(
                      controller: contentsController,
                      minLines: 10,
                      maxLines: 10,
                      style: AppTextStyles.body14R(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        border: InputBorder.none,
                        hintText: '내용을 입력해주세요.',
                        hintStyle: AppTextStyles.body14R(
                          color: AppColor.black20,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Row(
                        children: [
                          Tag(
                            text: tag1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                ButtonSmall(
                  width: 100,
                  onTap: () {
                    cancelAction();
                  },
                  text: '취소하기',
                  outline: true,
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ButtonSmall(
                    width: 100,
                    onTap: () {
                      submitAction();
                    },
                    text: '등록하기',
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
