import 'package:flutter/material.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/button_small.dart';

class DescriptionWithOneButton extends StatelessWidget {
  const DescriptionWithOneButton(
      {super.key,
      required this.mainMessage,
      required this.subMessage,
      required this.buttonTitle});

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
        height: 153,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${mainMessage}',
              style: AppTextStyles.body16B(color: Colors.black),
            ),
            SizedBox(height: 4),
            Text(
              '${subMessage}',
              style: AppTextStyles.body12R(color: Color(0xFF999999)),
            ),
            SizedBox(height: 20),
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

void showDialog_7(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DescriptionWithOneButton(
        mainMessage: '삭제할거니',
        subMessage: '진짜니',
        buttonTitle: '웅그!',
      );
    },
  );
}
