import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spec/controller/me/avatar_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/avatar_color.dart';
import 'package:spec/util/avatar_item_assets.dart';
import 'package:spec/view/widget/avatar/palette.dart';

enum AvatarAssetType { hair, face, emotion, item, itemForStack }

getRoute(AvatarAssetType type) {
  switch (type) {
    case AvatarAssetType.hair:
      return 'assets/avatar/Hair/';
    case AvatarAssetType.face:
      return 'assets/avatar/Face/';
    case AvatarAssetType.emotion:
      return 'assets/avatar/Emotion/';
    case AvatarAssetType.item:
      return 'assets/avatar/Item_Only';
    case AvatarAssetType.itemForStack:
      return 'assets/avatar/Item';
    default:
      return null;
  }
}

assetLength(AvatarAssetType type) {
  switch (type) {
    case AvatarAssetType.hair:
      return 24;
    case AvatarAssetType.face:
      return 9;
    case AvatarAssetType.emotion:
      return 24;
    case AvatarAssetType.item:
      return 18;
    default:
      return null;
  }
}

class AvatarCard extends StatelessWidget {
  const AvatarCard({
    super.key,
    required this.type,
  });
  final AvatarAssetType type;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AvatarController>();
    final path = getRoute(type);
    final length = assetLength(type);

    if (path == null || length == null) return Container();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        type == AvatarAssetType.hair
            ? Container(
                color: Colors.white,
                child: Palette(
                  colorPicker: controller.selectColor,
                ),
              )
            : Container(
                height: 16,
                color: Colors.white,
              ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(15),
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            itemCount: length,
            itemBuilder: (context, index) {
              String imageName = (type == AvatarAssetType.face)
                  ? "on_${type.name}_${index + 1}"
                  : "off_${type.name}_${index + 1}";
              String imagePath = "$path$imageName.svg";
              return GestureDetector(
                onTap: () {
                  controller.selectItems(type, imagePath);
                },
                child: Container(
                  //@todo 선택된 아이템 컨테이더 디자인 다르게하기
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(
                      color: AppColor.black10,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: (type == AvatarAssetType.item)
                      ? SvgPicture.asset(
                          '$path/off_${type.name}_${avatarItemAssets[index]}.svg',
                        )
                      : Stack(
                          children: [
                            SvgPicture.asset(
                              'assets/avatar/Face/on_face_1.svg',
                            ),
                            type == AvatarAssetType.hair
                                ? Obx(
                                    () => SvgPicture.asset(imagePath,
                                        color: controller.hairColor?.value),
                                  )
                                : SvgPicture.asset(
                                    imagePath,
                                  ),
                          ],
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
