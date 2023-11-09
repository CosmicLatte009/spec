import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/create_mogak_controller.dart';
import 'package:spec/view/widget/popup/popup.dart';
import 'package:spec/view/widget/select/custom_radio_group.dart';

class PartyStatePopup extends StatefulWidget {
  const PartyStatePopup({
    super.key,
    required this.items,
  });
  final List<String> items;

  @override
  State<PartyStatePopup> createState() => _PartyStatePopupState();
}

class _PartyStatePopupState extends State<PartyStatePopup> {
  var controller = Get.find<CreateMogakController>();

  @override
  Widget build(BuildContext context) {
    return Popup(
      label: '모집 상태',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 24,
          ),
          Obx(
            () => CustomRadioGroup(
              items: widget.items,
              tileColorActive: true,
              selectedIndex: controller.selectedIndex.value,
              onItemSelect: (index) {
                controller.updateIndex(index);
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
