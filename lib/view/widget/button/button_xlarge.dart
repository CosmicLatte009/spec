import 'package:flutter/material.dart';
import '../../../util/app_color.dart';

class ButtonXlarge extends StatelessWidget {
  const ButtonXlarge({
    super.key,
    required this.controller,
    required this.text,
    this.disabled = false,
  });

  final Function() controller;
  final String text;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller,
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
          style: TextStyle(
            color: disabled ? AppColor.black20 : AppColor.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
