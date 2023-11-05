import 'package:flutter/material.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

class TalkEditingPopup extends StatelessWidget {
  TalkEditingPopup({
    Key? key,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.only(
            top: 99,
            left: 10,
            right: 10,
          ),
          child: Column(
            children: [
              Container(
                height: 206,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 32.0),
                  child: TextField(
                    controller: controller,
                    minLines: 10,
                    maxLines: 10,
                    style: AppTextStyles.body14R(),
                    decoration: InputDecoration(
                      hintText: '내용을 입력해주세요.',
                      hintStyle: AppTextStyles.body14R(color: AppColor.black20),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    width: 100,
                    height: 32,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    text: '취소하기',
                    type: ButtonType.outline,
                  ),
                  CustomButton(
                    width: 100,
                    height: 32,
                    onTap: onSubmit,
                    text: '등록하기',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
