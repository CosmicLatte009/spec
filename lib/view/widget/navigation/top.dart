import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// 사용자 지정 앱 바
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: Padding(
        padding: EdgeInsets.only(left: 10),
        child: SvgPicture.asset(
          'assets/icons/svgs/SFACE.svg',
          width: 63,
          height: 13,
        ),
      ),
      // 여기에 다른 AppBar 속성을 추가할 수 있습니다.
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56); // 앱 바의 높이 설정
}
