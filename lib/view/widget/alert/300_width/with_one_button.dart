import 'package:flutter/material.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class WithOneButton extends StatelessWidget {
  final String? message;

  const WithOneButton({super.key, required this.message});
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
              '$message',
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
                  text: '삭제하기',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showDialog_2(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const WithOneButton(
        message: '우악 우악',
      );
    },
  );
}
