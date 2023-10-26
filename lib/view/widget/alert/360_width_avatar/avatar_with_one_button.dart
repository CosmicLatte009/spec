import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/button_small.dart';

class AvatarhWithOneButton extends StatelessWidget {
  const AvatarhWithOneButton({
    super.key,
    required this.avatarSvg,
  });

  final String avatarSvg;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 원하는 테두리 반지름 설정
      ),
      content: SizedBox(
        width: 242,
        height: 203,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 44,
              height: 40,
              child: SvgPicture.asset(
                avatarSvg,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '아바타가 저장되었습니다.',
              style: AppTextStyles.body16B(color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              '언제든지 수정이 가능합니다.',
              style: AppTextStyles.body12R(color: const Color(0xFF999999)),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonSmall(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: '닫기',
                  width: 180,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showDialog_9(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AvatarhWithOneButton(
        avatarSvg: 'assets/icons/svgs/SFACE.svg',
      );
    },
  );
}
