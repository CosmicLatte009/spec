import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/create_mogak_controller.dart';
import 'package:spec/view/widget/popup/popup.dart';
import 'package:spec/view/widget/select/custom_radio_group.dart';

class PartyStatePopup extends StatefulWidget {
  const PartyStatePopup({
    super.key,
  });

  @override
  State<PartyStatePopup> createState() => _PartyStatePopupState();
}

class _PartyStatePopupState extends State<PartyStatePopup> {
  var controller = Get.find<CreateMogakController>();
  List visiblityStatus = ['작성중', '모집중', '모집완료'];

  @override
  Widget build(BuildContext context) {
    return Popup(
      label: '참여자 목록',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 24,
          ),
          Obx(
            () => CustomRadioGroup(
              items: visiblityStatus,
              tileColorActive: true,
              selectedIndex: controller.selectedIndex,
              onItemSelect: (index) {
                controller.selectedIndex(index);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
