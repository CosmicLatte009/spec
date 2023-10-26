import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<String> bottomNavBarLabels = [
    '홈',
    '톡!',
    '캐치업!',
    '모각코!',
    '마이페이지',
  ];
  final List<List<SvgPicture>> bottomNavBarItems = [
    [
      SvgPicture.asset(
        'assets/icons/svgs/Home_2.svg',
        width: 30,
        height: 30,
      ),
      SvgPicture.asset(
        'assets/icons/svgs/Home.svg',
        width: 30,
        height: 30,
      ),
    ],
    [
      SvgPicture.asset(
        'assets/icons/svgs/Community_2.svg',
        width: 30,
        height: 30,
      ),
      SvgPicture.asset(
        'assets/icons/svgs/Community.svg',
        width: 30,
        height: 30,
      )
    ],
    [
      SvgPicture.asset(
        'assets/icons/svgs/Lounge_2.svg',
        width: 30,
        height: 30,
      ),
      SvgPicture.asset(
        'assets/icons/svgs/Lounge.svg',
        width: 30,
        height: 30,
      ),
    ],
    [
      SvgPicture.asset(
        'assets/icons/svgs/Work_2.svg',
        width: 30,
        height: 30,
      ),
      SvgPicture.asset(
        'assets/icons/svgs/Work.svg',
        width: 30,
        height: 30,
      ),
    ],
    [
      SvgPicture.asset(
        'assets/icons/svgs/woman-a_2.svg',
        width: 30,
        height: 30,
      ),
      SvgPicture.asset(
        'assets/icons/svgs/woman-a.svg',
        width: 30,
        height: 30,
      ),
    ],
  ];

  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      child: BottomNavigationBar(
        unselectedLabelStyle: AppTextStyles.body12R(color: Color(0xFF999999)),
        selectedLabelStyle: AppTextStyles.body12R(color: AppColor.primary80),
        type: BottomNavigationBarType.fixed,
        items: List.generate(widget.bottomNavBarItems.length, (index) {
          return BottomNavigationBarItem(
            icon: widget.bottomNavBarItems[index]
                [widget.currentIndex == index ? 1 : 0],
            label: widget.bottomNavBarLabels[index], // 라벨을 적절하게 설정
          );
        }),
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
      ),
    );
  }
}
