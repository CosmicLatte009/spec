import 'package:flutter/material.dart';
import 'package:spec/view/widget/avatar/default_circle_avatar.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class AvatarWithRole extends StatelessWidget {
  const AvatarWithRole({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const DefaultCircleAvatar(),
        Positioned(
          right: 0,
          left: 0,
          bottom: -6,
          child: CustomButton(
            text: '개발자/1기', //@todo role + '/' + '1기'? 1기는 어디서 나온 건지?
            height: 12,
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
