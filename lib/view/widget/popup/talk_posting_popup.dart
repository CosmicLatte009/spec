import 'package:flutter/material.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import 'package:spec/view/widget/popup/popup.dart';

import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

class TalkPostingPopup extends StatelessWidget {
  const TalkPostingPopup({
    super.key,
    required this.contentsController,
    required this.submitAction,
    required this.cancelAction,
  });

  final TextEditingController contentsController;
  final Function() submitAction;
  final Function() cancelAction;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Popup(
            isWide: true,
            shadow: true,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: TextField(
                    controller: contentsController,
                    minLines: 10,
                    maxLines: 10,
                    style: AppTextStyles.body14R(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      border: InputBorder.none,
                      hintText: '내용을 입력해주세요.',
                      hintStyle: AppTextStyles.body14R(
                        color: AppColor.black20,
                      ),
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     CustomButton(
                //       height: 32,
                //       onTap: () {
                //         cancelAction();
                //       },
                //       text: '취소하기',
                //       type: ButtonType.outline,
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(right: 8.0),
                //       child: CustomButton(
                //         height: 32,
                //         onTap: () {
                //           submitAction();
                //         },
                //         text: '등록하기',
                //         type: ButtonType.main,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
