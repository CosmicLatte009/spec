import 'package:flutter/material.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/avatar/default_avatar.dart';
import 'package:spec/view/widget/button/button_xsmall.dart';
import 'package:spec/view/widget/popup/popup.dart';

class ProfilePopup extends StatelessWidget {
  const ProfilePopup({
    super.key,
    required this.name,
    required this.role,
    required this.position,
  });
  final String name;
  final String role;
  final String position;

  @override
  Widget build(BuildContext context) {
    return Popup(
      label: '프로필',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 34,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    //아바타 완성되면 수정하기
                    clipBehavior: Clip.none,
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColor.primary05,
                        radius: 30,
                        child: DefaultAvatar(),
                      ),
                      Positioned(
                        right: 0,
                        left: 0,
                        bottom: -10,
                        child: Text(
                          position,
                          style: AppTextStyles.body12R(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    name,
                    style: AppTextStyles.body14B(),
                  ),
                  const SizedBox(
                    width: 2.5,
                  ),
                  ButtonXsmall(
                    //버튼 완성되면 컬러 바꾸기
                    controller: () {},
                    text: role,
                    width: 47,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
