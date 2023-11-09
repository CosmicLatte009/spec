import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreatedAvatar extends StatelessWidget {
  const CreatedAvatar({
    super.key,
    required this.selectedItems,
    this.screenshotController,
    this.capturedImg,
    this.hairColor,
  });
  final Map<String, dynamic> selectedItems;
  final screenshotController;
  final capturedImg;
  final hairColor;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenshotController
          .captureFromWidget(
        InheritedTheme.captureAll(
          context,
          Stack(
            children: selectedItems.entries
                .where((entry) => entry.value != null)
                .map((entry) => SvgPicture.asset(
                      entry.value!,
                      color: entry.key == 'hair' ? hairColor.value : null,
                    ))
                .toList(),
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

    return Stack(
      children: selectedItems.entries
          .where((entry) => entry.value != null)
          .map((entry) => SvgPicture.asset(
                entry.value!,
                color: entry.key == 'hair' ? hairColor.value : null,
              ))
          .toList(),
    );
  }
}
