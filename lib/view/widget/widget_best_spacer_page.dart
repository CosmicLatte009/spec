import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/model/best_spacer.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/avatar/user_avatar.dart';

class BestSpacerWidgetPage extends StatelessWidget {
  final BestSpacer bestSpacer;
  final bool isFirstPlace;
  final Widget badge; // 뱃지 위젯을 위한 새로운 파라미터 추가

  BestSpacerWidgetPage({
    Key? key,
    required this.bestSpacer,
    this.isFirstPlace = false,
    required this.badge, // 필수 파라미터로 설정
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = isFirstPlace ? 143 : 107;
    double height = isFirstPlace ? 165 : 137;

    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE6E6E6), width: 1),
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UserAvatar(
                shortName: bestSpacer.position,
                nickName: bestSpacer.nickname,
                direction: BadgeDirection.column,
                role: bestSpacer.role,
                roleHeight: width == 143 ? 22 : 17,
                avatarSize: width == 143 ? AvatarSize.w60 : AvatarSize.w40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 15,
                  ),
                  SizedBox(width: 5),
                  Text('${bestSpacer.temperature}'),
                ],
              ),
            ],
          ),
          // 조건에 따라 뱃지를 표시합니다.
          Positioned(
            right: 5,

            child: badge, // 뱃지 위젯을 위치시킵니다.
          ),
        ],
      ),
    );
  }
}
