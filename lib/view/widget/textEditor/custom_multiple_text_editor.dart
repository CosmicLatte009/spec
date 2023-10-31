import 'package:flutter/material.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/tag_editor.dart';

class CustomMultipleTextEditor extends StatelessWidget {
  const CustomMultipleTextEditor({
    super.key,
    required this.titleController,
    required this.contentsController,
    required this.tagsController,
  });
  final TextEditingController titleController;
  final TextEditingController contentsController;
  final TextEditingController tagsController;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  // maxLength: 50,
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
                TextField(
                  controller: contentsController,
                  minLines: 8,
                  maxLines: 8,
                  // maxLength: 500,
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
                TagEditor(
                  controller: tagsController,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
