import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/create_mogak_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/popup/popup.dart';

class PartyNumberPopup extends StatelessWidget {
  const PartyNumberPopup({
    super.key,
    this.partyNum = 0,
  });
  final int? partyNum;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CreateMogakController>();

    return Popup(
      label: '모집인원',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: controller.maxNumberController,
                      keyboardType: TextInputType.number,
                      // inputFormatters: <TextInputFormatter>[
                      //   FilteringTextInputFormatter.digitsOnly
                      // ],
                      style: AppTextStyles.header32(),
                      decoration: InputDecoration(
                        hintText: '0',
                        hintStyle: AppTextStyles.header32(
                          color: AppColor.black20,
                        ),
                        filled: true,
                        fillColor: AppColor.back05,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
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
