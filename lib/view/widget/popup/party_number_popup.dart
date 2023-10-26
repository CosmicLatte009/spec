import 'package:flutter/material.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/popup/popup.dart';

class PartyNumberPopup extends StatelessWidget {
  const PartyNumberPopup({
    super.key,
    required this.partyNum,
  });
  final int partyNum;

  @override
  Widget build(BuildContext context) {
    return Popup(
      label: '모집인원',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColor.back05,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      partyNum.toString(),
                      style: AppTextStyles.header32(
                        color: AppColor.black20,
                      ),
                    ),
                  ),
                ),
                Text(
                  '명',
                  style: AppTextStyles.body18B(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
