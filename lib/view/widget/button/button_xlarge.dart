import 'package:flutter/material.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

class ButtonXlarge extends StatelessWidget {
  const ButtonXlarge({
    super.key,
    required this.text,
    this.onTap,
    this.disabled = false,
  });

  final String text;
  final Function()? onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        width: 370,
        height: 56,
        decoration: BoxDecoration(
          color: disabled ? AppColor.black05 : AppColor.primary80,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: AppTextStyles.body18M(
            color: disabled ? AppColor.black20 : AppColor.white,
          ),
        ),
      ),
    );
  }
}
