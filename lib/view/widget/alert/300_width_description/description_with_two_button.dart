import 'package:flutter/material.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/button_small.dart';

class DescriptionWithTwoButton extends StatelessWidget {
  const DescriptionWithTwoButton(
      {super.key,
      required this.mainMessage,
      required this.subMessage,
      required this.buttonTitle1,
      required this.buttonTitle2});

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
      content: SizedBox(
        width: 242,
        height: 153,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              mainMessage,
              style: AppTextStyles.body16B(color: Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              subMessage,
              style: AppTextStyles.body12R(color: const Color(0xFF999999)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonSmall(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: buttonTitle1,
                  width: 104,
                  outline: true,
                ),
                const SizedBox(width: 10),
                ButtonSmall(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: buttonTitle2,
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

void showDialog_6(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const DescriptionWithTwoButton(
        mainMessage: 'ㄹㅇ 댓글 삭제',
        subMessage: '후회하지마..',
        buttonTitle1: '헉 안돼',
        buttonTitle2: '웅 안해',
      );
    },
  );
}
