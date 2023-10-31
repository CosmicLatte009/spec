import 'package:flutter/material.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/tag.dart';

class CustomMultipleTextEditor extends StatelessWidget {
  const CustomMultipleTextEditor({
    super.key,
    required this.titleController,
    required this.contentsController,
  });
  final TextEditingController titleController;
  final TextEditingController contentsController;

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
              color: Colors.white,
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
                    const Positioned(
                      bottom: 0,
                      child: Row(
                        children: [
                          // 태그들
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
