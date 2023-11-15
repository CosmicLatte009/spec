import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

class UpAndCommentLength extends StatelessWidget {
  const UpAndCommentLength(
      {super.key, required this.commentLength, required this.upLength});

  final int commentLength;
  final int upLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: commentLength > 0,
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/svgs/Chat2.svg',
                  width: 16,
                ),
                Text(
                  '$commentLength',
                  style: AppTextStyles.body12R(color: AppColor.primary80),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Visibility(
            visible: upLength > 0,
            child: Row(
              children: [
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
          ),
        ],
      ),
    );
  }
}
