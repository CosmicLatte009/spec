import 'package:flutter/material.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class WithTwoButton extends StatelessWidget {
  const WithTwoButton(
      {super.key,
      required this.button1,
      required this.button2,
      required this.message,
      this.callback1,
      required this.callback2});

  final String button1;
  final String button2;
  final callback1;
  final callback2;

  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 원하는 테두리 반지름 설정
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 36, 16, 28),
      content: SizedBox(
        width: 242,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: AppTextStyles.body16B(color: Colors.black),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomButton(
                    height: 32,
                    type: ButtonType.outline,
                    onTap: () {
                      if (callback1 != null) {
                        callback1();
                      }
                      Navigator.of(context).pop();
                    },
                    text: button1,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    height: 32,
                    onTap: () {
                      callback2();
                      Navigator.of(context).pop();
                    },
                    text: button2,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// void showDialog_1(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return const WithTwoButton(
//         message: '둘 중에 하나만 골라',
//         button1: '좋아',
//         button2: '싫어',
//       );
//     },
//   );
// }
