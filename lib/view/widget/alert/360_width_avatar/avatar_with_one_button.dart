import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/me/profile_controller.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class AvatarWithOneButton extends StatelessWidget {
  const AvatarWithOneButton({
    super.key,
    required this.mainMessage,
    this.subMessage,
    this.buttonTitle,
    this.avatar,
    this.uploadedAvatar,
  });

  final String? avatar;
  final String mainMessage;
  final String? subMessage;
  final String? buttonTitle;
  final ImageProvider? uploadedAvatar;

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.find<ProfileController>();

    String? imageUrl;
    if (controller.curInfo.value?.avatar != null &&
        controller.curInfo.value!.avatar!.isNotEmpty) {
      imageUrl = controller.curInfo.value!.avatar!;
    } else if (avatar != null && avatar!.isNotEmpty) {
      imageUrl = avatar!;
    } else {
      imageUrl = null;
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 원하는 테두리 반지름 설정
      ),
      content: SizedBox(
        width: 242,
        height: 203,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            uploadedAvatar != null
                ? SizedBox(
                    width: 80,
                    height: 80,
                    child: Image(
                      image: uploadedAvatar!,
                    ))
                : SizedBox(
                    width: 80,
                    height: 80,
                    child: imageUrl != null
                        ? Image.network(
                            imageUrl,
                          )
                        : Image.asset('assets/icons/pngs/man-a.png')),
            const SizedBox(height: 8),
            Text(
              mainMessage,
              style: AppTextStyles.body16B(color: Colors.black),
            ),
            if (subMessage != null)
              Column(
                children: [
                  const SizedBox(height: 8),
                  Text(
                    subMessage!,
                    style:
                        AppTextStyles.body12R(color: const Color(0xFF999999)),
                  ),
                ],
              ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  size: ButtonSize.small,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: buttonTitle ?? '닫기',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// void showDialog_9(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return const AvatarWithOneButton(
//         avatarSvg: 'assets/icons/svgs/SFACE.svg',
//       );
//     },
//   );
// }
