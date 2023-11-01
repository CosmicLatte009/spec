import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spec/util/app_text_style.dart';
import '../../../util/app_color.dart';

enum ListButtonType {
  setting,
  count,
  recruitCount,
  recruitState,
}

class ListButton extends StatelessWidget {
  const ListButton({
    super.key,
    required this.text,
    required this.listType,
    this.onTap,
    this.count = 0,
    this.recruitState = '작성중',
  });
  final Function()? onTap;
  final String text;
  final int count;
  final ListButtonType listType;
  final String recruitState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(right: 6),
            width: double.infinity,
            height: 38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black80,
                  ),
                ),
                if (listType == ListButtonType.setting)
                  SvgPicture.asset('assets/icons/svgs/Right.svg'),
                if (listType == ListButtonType.count)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: count != 0 ? AppColor.primary05 : AppColor.black05,
                      borderRadius: BorderRadius.circular(4),
                      border: count != 0
                          ? Border.all(color: AppColor.primary80, width: 1)
                          : Border.all(color: AppColor.black05, width: 1),
                    ),
                    child: Text(
                      '$count개',
                      style: AppTextStyles.body12R(
                          color: count != 0
                              ? AppColor.primary80
                              : AppColor.black60),
                    ),
                  ),
                if (listType == ListButtonType.recruitCount)
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: '$count',
                          style: AppTextStyles.body16M(
                              color: count != 0
                                  ? AppColor.primary80
                                  : AppColor.black80)),
                      TextSpan(
                          text: '명',
                          style:
                              AppTextStyles.body16M(color: AppColor.black80)),
                    ]),
                  ),
                if (listType == ListButtonType.recruitState)
                  Text(recruitState,
                      style: AppTextStyles.body16M(color: AppColor.primary80)),
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/icons/svgs/Bottom_dot.svg',
          ),
        ],
      ),
    );
  }
}
