import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:spec/controller/me/avatar_controller.dart';

class CreatedAvatar extends StatefulWidget {
  const CreatedAvatar({
    super.key,
    this.screenshotController,
    this.capturedImg,
  });
  final screenshotController;
  final capturedImg;

  @override
  State<CreatedAvatar> createState() => _CreatedAvatarState();
}

class _CreatedAvatarState extends State<CreatedAvatar> {
  @override
  Widget build(BuildContext context) {
    AvatarController controller = Get.find<AvatarController>();
    return Screenshot(
      controller: widget.screenshotController,
      child: Obx(
        () => Stack(
          children: controller.selectedItems.entries
              .where((entry) => entry.value != null)
              .map((entry) => SvgPicture.asset(
                    entry.value!,
                    color:
                        entry.key == 'hair' ? controller.hairColor.value : null,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
