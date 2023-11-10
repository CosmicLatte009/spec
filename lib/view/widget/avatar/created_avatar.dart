import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spec/controller/me/avatar_controller.dart';

class CreatedAvatar extends StatelessWidget {
  const CreatedAvatar({
    super.key,
    this.screenshotController,
    this.capturedImg,
  });
  final screenshotController;
  final capturedImg;

  @override
  Widget build(BuildContext context) {
    AvatarController controller = Get.find<AvatarController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenshotController
          .captureFromWidget(
        InheritedTheme.captureAll(
          context,
          Obx(
            () => Stack(
              children: controller.selectedItems.entries
                  .where((entry) => entry.value != null)
                  .map((entry) => SvgPicture.asset(
                        entry.value!,
                        color: entry.key == 'hair'
                            ? controller.hairColor.value
                            : null,
                      ))
                  .toList(),
            ),
          ),
        ),
        delay: const Duration(milliseconds: 100),
        context: context,
      )
          .then((capturedImage) {
        // handle captured Image
        capturedImg.value = capturedImage;
      });
    });

    return Obx(
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
    );
  }
}
