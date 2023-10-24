import 'package:flutter/material.dart';
import 'package:spec/view/widget/tag_edit_mode.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

class Tag extends StatefulWidget {
  const Tag({
    super.key,
    this.text,
    required this.controller,
  });

  final String? text;
  final TextEditingController controller;

  @override
  State<Tag> createState() => _TagState();
}

class _TagState extends State<Tag> {
  bool isEditMode = false;
  void handleEdit() {
    isEditMode = !isEditMode;
    print(isEditMode);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handleEdit();
        print(widget.text);
        setState(() {});
      },
      child: isEditMode == false
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
              curText: widget.text,
              isEditMode: isEditMode,
              handleEdit: handleEdit,
              controller: widget.controller,
            ),
    );
  }
}
