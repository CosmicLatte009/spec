import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spec/util/app_color.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key, required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColor.primary80,
      onPressed: onPressed,
      child: SvgPicture.asset(
        'assets/icons/svgs/Write.svg',
        color: Colors.white,
      ),
    );
  }
}
