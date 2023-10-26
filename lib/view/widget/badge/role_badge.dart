import 'package:flutter/material.dart';
import 'package:spec/util/app_text_style.dart';
import '../../../util/app_color.dart';

class RoleBadge extends StatelessWidget {
  const RoleBadge({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      height: 22,
      decoration: BoxDecoration(
        color: AppColor.black05,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: AppTextStyles.body12R(color: AppColor.black60),
      ),
    );
  }
}
