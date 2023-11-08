import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class IconTextWithOneButton extends StatelessWidget {
  const IconTextWithOneButton(
      {super.key,
      required this.svgPath,
      required this.mainMessage,
      required this.subMessage,
      required this.buttonTitle,
      this.onTap});

  final String svgPath;
  final String mainMessage;
  final String subMessage;
  final String buttonTitle;
  final Function()? onTap;
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
              mainMessage,
              style: AppTextStyles.body16B(color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              subMessage,
              style: AppTextStyles.body12R(color: const Color(0xFF999999)),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  width: 100,
                  height: 32,
                  onTap: onTap ??
                      () {
                        Navigator.pop(context);
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

void showDialog_5(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const IconTextWithOneButton(
        svgPath: 'assets/icons/svgs/SFACE.svg',
        mainMessage: 'adsds',
        subMessage: 'sdsd',
        buttonTitle: 'sfsf',
      );
    },
  );
}
