import 'package:flutter/material.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class DescriptionWithTwoButton extends StatelessWidget {
  const DescriptionWithTwoButton(
      {super.key,
      required this.mainMessage,
      required this.subMessage,
      required this.buttonTitle1,
      required this.buttonTitle2,
      this.callback1,
      this.callback2,
      this.onSubmit});

  final String mainMessage;
  final String subMessage;
  final String buttonTitle1;
  final String buttonTitle2;
  final callback1;
  final callback2;
  final Function()? onSubmit;

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
                    text: buttonTitle1,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    height: 32,
                    onTap: () {
                      if (callback2 != null) {
                        callback2();
                      }
                      if (onSubmit != null) {
                        onSubmit();
                      }
                      Navigator.of(context).pop();
                    },
                    text: buttonTitle2,
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

// void showDialog_6(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return const DescriptionWithTwoButton(
//         mainMessage: 'ㄹㅇ 댓글 삭제',
//         subMessage: '후회하지마..',
//         buttonTitle1: '헉 안돼',
//         buttonTitle2: '웅 안해',
//       );
//     },
//   );
// }
