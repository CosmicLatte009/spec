import 'package:flutter/material.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/button_small.dart';
import 'package:spec/view/widget/tag.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.titleController,
    required this.contentsController,
    required this.tag1Controller,
    required this.tag2Controller,
  });
  final TextEditingController titleController;
  final TextEditingController contentsController;
  final TextEditingController tag1Controller;
  final TextEditingController tag2Controller;

  @override
  Widget build(BuildContext context) {
    bool isEditMode = false;
    void handleEdit() {
      isEditMode = !isEditMode;
      print(isEditMode);
    }

    return Column(
      children: [
        Container(
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
              //제목
              TextField(
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
                          controller: tag1Controller,
                          handleEdit: handleEdit,
                        ),
                        const SizedBox(width: 8),
                        Tag(
                          controller: tag2Controller,
                          handleEdit: handleEdit,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                ButtonSmall(
                  width: 100,
                  controller: () {
                    print('cancel');
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
                    controller: () {
                      print('submit');
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
