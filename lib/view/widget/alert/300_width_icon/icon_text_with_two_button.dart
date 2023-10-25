import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/button_small.dart';

class IconTextWithTwoButton extends StatelessWidget {
  const IconTextWithTwoButton(
      {super.key,
      required this.svgPath,
      required this.mainMessage,
      required this.subMessage,
      required this.buttonTitle1,
      required this.buttonTitle2});

  final String svgPath;
  final String mainMessage;
  final String subMessage;
  final String buttonTitle1;
  final String buttonTitle2;

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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonSmall(
                  controller: () {
                    Navigator.of(context).pop();
                  },
                  text: '${buttonTitle1}',
                  width: 104,
                  outline: true,
                ),
                SizedBox(width: 10),
                ButtonSmall(
                  controller: () {
                    Navigator.of(context).pop();
                  },
                  text: '${buttonTitle2}',
                  width: 104,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showDialog_4(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return IconTextWithTwoButton(
        svgPath: 'assets/SFACE.svg',
        mainMessage: '조심하세요',
        subMessage: '안그러면 클납니다',
        buttonTitle1: '알아서 할게요',
        buttonTitle2: '넵 일단 조심할게요',
      );
    },
  );
}
