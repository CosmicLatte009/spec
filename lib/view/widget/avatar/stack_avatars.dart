import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

class StackAvatars extends StatelessWidget {
  const StackAvatars(
      {super.key, required this.commentLength, required this.upLength});

  final int commentLength;
  final int upLength;

  List<Widget> generatePositionedAvatars(int count) {
    final int avatarsToShow = count > 3 ? 3 : count;
    return List.generate(avatarsToShow, (index) {
      return Positioned(
        left: 12.0 * index,
        child: CircleAvatar(
          radius: 10.0,
          backgroundColor: AppColor.primary05,
          child: Image.asset(
            'assets/icons/pngs/man-a.png',
            width: 13.81,
            height: 41.81,
          ),
        ),
      );
    });
  }

  double computeStackWidth(int count) {
    if (count == 0) return 0;
    final int avatarsToShow = count > 3 ? 3 : count;
    return 12.0 * (avatarsToShow - 1) + 20;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              SizedBox(
                width: computeStackWidth(commentLength),
                height: 20,
                child:
                    Stack(children: generatePositionedAvatars(commentLength)),
              ),
              const SizedBox(width: 2),
              SvgPicture.asset(
                'assets/icons/svgs/plus.svg',
                width: 16,
              ),
              Text(
                '$commentLength',
                style: AppTextStyles.body12R(color: AppColor.primary80),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              SizedBox(
                width: computeStackWidth(upLength),
                height: 20,
                child: Stack(
                  children: generatePositionedAvatars(upLength),
                ),
              ),
              const SizedBox(width: 2),
              SvgPicture.asset(
                'assets/icons/svgs/Like.svg',
                width: 16,
              ),
              Text(
                '$upLength',
                style: AppTextStyles.body12R(color: AppColor.primary80),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
