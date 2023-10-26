import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/button_small.dart';

class IconTextWithOneButton extends StatelessWidget {
  const IconTextWithOneButton(
      {super.key,
      required this.svgPath,
      required this.mainMessage,
      required this.subMessage,
      required this.buttonTitle});

  final String svgPath;
  final String mainMessage;
  final String subMessage;
  final String buttonTitle;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 원하는 테두리 반지름 설정
      ),
      content: Container(
        width: 242,
        height: 203,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              child: SvgPicture.asset(
                '${svgPath}',
              ),
            ),
            Text(
              '${mainMessage}',
              style: AppTextStyles.body16B(color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              '${subMessage}',
              style: AppTextStyles.body12R(color: Color(0xFF999999)),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonSmall(
                  controller: () {
                    Navigator.of(context).pop();
                  },
                  text: '${buttonTitle}',
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

void showDialog_5(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return IconTextWithOneButton(
        svgPath: 'assets/icons/svgs/SFACE.svg',
        mainMessage: 'adsds',
        subMessage: 'sdsd',
        buttonTitle: 'sfsf',
      );
    },
  );
}
