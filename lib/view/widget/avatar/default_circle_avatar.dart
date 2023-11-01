import 'package:flutter/material.dart';
import 'package:spec/util/app_color.dart';

class DefaultCircleAvatar extends StatelessWidget {
  const DefaultCircleAvatar({
    super.key,
    this.radius = 20,
    this.imageRadius = 33,
  });
  final double radius;
  final double imageRadius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColor.primary05,
      child: Image.asset(
        'assets/icons/pngs/man-a.png',
        width: imageRadius,
        height: imageRadius,
      ),
    );
  }
}
