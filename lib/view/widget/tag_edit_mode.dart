import 'package:flutter/material.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';

class TagEditMode extends StatefulWidget {
  const TagEditMode({
    super.key,
    this.curText,
    required this.isEditMode,
    this.handleEdit,
    required this.controller,
  });
  final String? curText;
  final bool isEditMode;
  final handleEdit;
  final TextEditingController controller;

  @override
  State<TagEditMode> createState() => _TagEditModeState();
}

class _TagEditModeState extends State<TagEditMode> {
  @override
  void initState() {
    super.initState();

    widget.controller.text = widget.curText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 22,
      child: TextField(
        controller: widget.controller,
        style: AppTextStyles.body12R(
          color: AppColor.black60,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.back05,
          hintText: '# 태그입력',
          hintStyle: AppTextStyles.body12R(
            color: AppColor.black30,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
