import 'package:flutter/material.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class WithTwoButton extends StatelessWidget {
  const WithTwoButton(
      {super.key,
      required this.button1,
      required this.button2,
      required this.message});

  final String button1;
  final String button2;

  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 원하는 테두리 반지름 설정
      ),
      content: SizedBox(
        width: 242,
        height: 139,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                  width: 100,
                  height: 32,
                  type: ButtonType.outline,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: '${button1}',
                ),
                SizedBox(width: 10),
                CustomButton(
                  width: 100,
                  height: 32,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: '${button2}',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void showDialog_1(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const WithTwoButton(
        message: '둘 중에 하나만 골라',
        button1: '좋아',
        button2: '싫어',
      );
    },
  );
}
