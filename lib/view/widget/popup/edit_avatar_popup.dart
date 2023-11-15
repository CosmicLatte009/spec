import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/me/avatar_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/view/widget/avatar/created_avatar.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import 'package:spec/view/widget/card/avatar_card.dart';
import 'package:spec/view/widget/popup/popup.dart';
import 'package:spec/view/widget/tab/custom_tabbar.dart';

class EditAvatarPopup extends GetView<AvatarController> {
  const EditAvatarPopup({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tabList = ["헤어", '피부', '표정', '아이템'];

    List<Widget> tabBarViewList = [
      const AvatarCard(type: AvatarAssetType.hair),
      const AvatarCard(type: AvatarAssetType.face),
      const AvatarCard(type: AvatarAssetType.emotion),
      const AvatarCard(type: AvatarAssetType.item),
    ];

    return Popup(
      label: '아바타 수정',
      isWide: true,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 4),
            //아바타
            CircleAvatar(
              backgroundColor: AppColor.primary05,
              radius: 60,
              child: CreatedAvatar(
                capturedImg: controller.imageUrl,
                screenshotController: controller.screenshotController,
              ),
            ),
            const SizedBox(height: 10),
            //아바타 탭 부분
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 500,
              ),
              child: CustomTabbar(
                tabList: tabList,
                tabBarViewList: tabBarViewList,
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onTap: controller.resetAvatar,
                        text: '초기화',
                        type: ButtonType.outline,
                        height: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomButton(
                        onTap: controller.captureAndUpload,
                        text: '저장하기',
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
