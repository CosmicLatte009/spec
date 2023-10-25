import 'package:flutter/material.dart';
import 'package:spec/util/app_text_style.dart';
import '../../../util/app_color.dart';

class ButtonMedium extends StatelessWidget {
  const ButtonMedium({
    super.key,
    required this.controller,
    required this.text,
    this.outline = false,
  });

  final Function() controller;
  final String text;
  final bool outline;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller,
      child: Container(
        alignment: Alignment.center,
        width: 165,
        height: 40,
        decoration: BoxDecoration(
          color: outline ? AppColor.primary05 : AppColor.primary80,
          borderRadius: BorderRadius.circular(6),
          border:
              outline ? Border.all(color: AppColor.strokeBlue, width: 1) : null,
        ),
        child: Text(text,
            style: AppTextStyles.body16R(
              color: outline ? AppColor.primary60 : AppColor.white,
            )),
      ),
    );
  }
}
