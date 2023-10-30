import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../util/app_color.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.svg,
    required this.onTap,
  });

  final String svg;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: CircleAvatar(
          radius: 15,
          backgroundColor: AppColor.primary05,
          child: SvgPicture.asset(
            svg,
          ),
        ),
      ),
    );
  }
}
