import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/me/me_mogak_controller.dart';
import 'package:spec/view/widget/alert/300_width_description/description_with_two_button.dart';
import 'package:spec/view/widget/avatar/stack_avatars.dart';
import 'package:spec/view/widget/button/button_circle.dart';
import 'package:spec/view/widget/button/orderby_button.dart';
import 'package:spec/view/widget/card/mogak_card.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';

class MeMogakPage extends GetView<MeMogakController> {
  const MeMogakPage({super.key});
  static const route = '/me/mogak';
  static const title = '내가 만든 그룹';

  @override
  Widget build(BuildContext context) {
    Rx<String> selectedId = ''.obs;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: GestureDetector(
        onTap: () {
          selectedId.value = '';
        },
        child: ListView(
          children: [
            const SizedBox(height: 24),
            const NavMenu(
              title: title,
              titleDirection: TitleDirection.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OrderbyButton(
                    onTap: () {
                      controller.filterController.toggleOrderBy();
                      controller.getMeMogak();
                    },
                  ),
                  const SizedBox(height: 24),
                  Obx(
                    () => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.meMogaks.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            selectedId.value = controller.meMogaks[index].id;
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  MogakCard(
                                      mogak: controller.meMogaks[index],
                                      mogakState: controller.mogakState(
                                        controller
                                            .meMogaks[index].visiblityStatus,
                                      ),
                                      isUped: controller.isUped(
                                          controller.meMogaks[index].id),
                                      controller: controller.toggleLike,
                                      title: title,
                                      isSelected: selectedId.value ==
                                          controller.meMogaks[index].id),
                                  Obx(
                                    () => selectedId.value ==
                                            controller.meMogaks[index].id
                                        ? Positioned(
                                            top: -15,
                                            right: 0,
                                            child: Row(
                                              children: [
                                                CircleButton(
                                                  svg:
                                                      'assets/icons/svgs/edit.svg',
                                                  onTap: () {
                                                    print('meMogaks[index].id');
                                                    Get.toNamed(
                                                      '/mogak/update/${controller.meMogaks[index].id}',
                                                    );
                                                    selectedId.value = '';
                                                  },
                                                ),
                                                const SizedBox(width: 8),
                                                CircleButton(
                                                  svg:
                                                      'assets/icons/svgs/Delete_Float.svg',
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return DescriptionWithTwoButton(
                                                          buttonTitle1: '취소하기',
                                                          buttonTitle2: '삭제하기',
                                                          mainMessage:
                                                              '내가 만든 그룹을 삭제하시겠습니까?',
                                                          subMessage:
                                                              '한번 삭제하면 복구가 불가능합니다.',
                                                          callback2: () {
                                                            controller.deleteMogak(
                                                                controller
                                                                    .meMogaks[
                                                                        index]
                                                                    .id);
                                                          },
                                                        );
                                                      },
                                                    );
                                                    selectedId.value = '';
                                                  },
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              StackAvatars(
                                commentLength:
                                    controller.meMogaks[index].childrenLength ??
                                        0,
                                upLength: controller
                                    .meMogaks[index].upProfiles.length,
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
