import 'package:flutter/material.dart';
import 'package:spec/view/widget/tag_edit_mode.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

class Tag extends StatefulWidget {
  const Tag({
    super.key,
    this.text,
    this.isEditMode = true,
    this.handleEdit,
    required this.controller,
  });

  final String? text;
  final bool isEditMode;
  final handleEdit;
  final TextEditingController controller;

  @override
  State<Tag> createState() => _TagState();
}

class _TagState extends State<Tag> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.handleEdit();
        setState(() {});
      },
      child: widget.isEditMode == false
          ? Container(
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
              child: Text(
                '# ${widget.text}',
                style: AppTextStyles.body12R(
                  color: AppColor.black60,
                ),
              ),
            )
          : TagEditMode(
              curText: widget.text ?? '',
              isEditMode: widget.isEditMode,
              handleEdit: widget.handleEdit,
              controller: widget.controller,
            ),
    );
  }
}
