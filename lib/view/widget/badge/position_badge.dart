import 'package:flutter/material.dart';
import 'package:spec/util/app_text_style.dart';
import '../../../util/app_color.dart';

class PositionBadge extends StatelessWidget {
  const PositionBadge({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      height: 18,
      decoration: BoxDecoration(
        color: AppColor.primary80,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: AppTextStyles.body12R(color: AppColor.white),
      ),
    );
  }
}
