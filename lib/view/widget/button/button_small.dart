import 'package:flutter/material.dart';
import '../../../util/app_color.dart';

class ButtonSmall extends StatelessWidget {
  const ButtonSmall({
    super.key,
    required this.controller,
    required this.text,
    required this.width,
    this.outline = false,
  });

  final Function() controller;
  final String text;
  final bool outline;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: 32,
        decoration: BoxDecoration(
          color: outline ? AppColor.primary05 : AppColor.primary80,
          borderRadius: BorderRadius.circular(6),
          border:
              outline ? Border.all(color: AppColor.strokeBlue, width: 1) : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: outline ? AppColor.primary60 : AppColor.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
