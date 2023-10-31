import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../controller/catchup_controller.dart';

class LikeButtonWidget extends GetView<CatchUpController> {
  final String catchUpId;
  final double iconSize; // Add an iconSize parameter

  LikeButtonWidget(
      {Key? key,
      required this.catchUpId,
      this.iconSize = 24.0}) // Default size is 24.0
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: IconButton(
            icon: Icon(
              controller.isLiked(catchUpId)
                  ? Icons.favorite
                  : Icons
                      .favorite_border, // Change to favorite_border for not liked
            ),
            color: controller.isLiked(catchUpId) ? Colors.red : Colors.grey,
            iconSize: iconSize, // Set the icon size
            onPressed: () => controller.sendLike(catchUpId),
          ),
        ));
  }
}
