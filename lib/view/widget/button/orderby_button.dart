import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spec/util/app_color.dart';

class OrderbyButton extends StatelessWidget {
  const OrderbyButton({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('OrderbyButton tapped');
        if (onTap != null) {
          onTap!();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            'assets/icons/svgs/Filter.svg',
            width: 16,
            height: 16,
          ),
          const SizedBox(
            width: 8,
          ),
          const Text(
            '날짜순',
            style: TextStyle(
              color: AppColor.primary,
            ),
          ),
        ],
      ),
    );
  }
}
