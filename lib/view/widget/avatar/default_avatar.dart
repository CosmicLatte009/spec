import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DefaultAvatar extends StatelessWidget {
  const DefaultAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          'assets/avatar/face/Face_smile.svg',
          width: 40,
        ),
        Positioned(
          top: -6,
          child: SvgPicture.asset(
            'assets/avatar/hair/Hair_short1_test.svg',
            width: 40,
          ),
        ),
      ],
    );
  }
}
