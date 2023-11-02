import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class IconWithOneButton extends StatelessWidget {
  const IconWithOneButton(
      {super.key,
      required this.svgPath,
      required this.message,
      required this.buttonTitle});

  final String svgPath;
  final String message;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 원하는 테두리 반지름 설정
      ),
      content: SizedBox(
        width: 242,
        height: 181,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset(
                svgPath,
              ),
            ),
            Text(
              message,
              style: AppTextStyles.body16B(color: Colors.black),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  size: ButtonSize.small,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: '${buttonTitle}',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void showDialog_3(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const IconWithOneButton(
        svgPath: 'assets/icons/svgs/SFACE.svg',
        message: '위험해요!',
        buttonTitle: '닫을래요',
      );
    },
  );
}
