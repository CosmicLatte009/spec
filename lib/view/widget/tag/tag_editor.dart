import 'package:flutter/material.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

class TagEditor extends StatefulWidget {
  const TagEditor({
    super.key,
    this.text,
    required this.controller,
  });

  final String? text;
  final TextEditingController controller;

  @override
  State<TagEditor> createState() => _TagState();
}

class _TagState extends State<TagEditor> {
  bool isEditMode = false;
  void handleEdit() {
    isEditMode = !isEditMode;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handleEdit();
        setState(() {});
      },
      child: isEditMode == false
          ? Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 24,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.back05,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '# 태그입력',
                        style: AppTextStyles.body12R(
                          color: AppColor.black60,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  alignment: Alignment.center,
                  height: 24,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.back05,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '# 태그입력',
                        style: AppTextStyles.body12R(
                          color: AppColor.black60,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Row(
              children: [
                if (widget.text != null && widget.text != "")
                  Wrap(
                    children: [
                      IntrinsicWidth(
                        child: Text(
                          '# ${widget.text}',
                          style: AppTextStyles.body12R(
                            color: AppColor.black60,
                          ),
                        ),
                      ),
                    ],
                  ),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    style: AppTextStyles.body12R(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      border: InputBorder.none,
                      hintText: '#를 이용해 태그를 입력해주세요',
                      hintStyle: AppTextStyles.body12R(
                        color: AppColor.black20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
