import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Top extends StatelessWidget {
  const Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFE7E7E7), // 테두리의 색상 설정
                width: 1.0, // 테두리의 두께 설정
              ),
            ),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 20,
          child: SvgPicture.asset(
            'assets/icons/svgs/SFACE.svg',
            width: 63,
            height: 13,
          ),
        ),
      ],
    );
  }
}
