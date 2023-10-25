import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DefaultAvatar extends StatelessWidget {
  const DefaultAvatar({
    super.key,
    this.width,
    this.hairPosition,
  });
  final double? width;
  final double? hairPosition;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          'assets/avatar/face/Face_smile.svg',
          width: width ?? 40,
        ),
        Positioned(
          top: hairPosition ?? -7,
          child: SvgPicture.asset(
            'assets/avatar/hair/Hair_short1_test.svg',
            width: width ?? 40,
          ),
        ),
      ],
    );
  }
}
