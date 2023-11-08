import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/me/me_mogak_controller.dart';
import 'package:spec/view/widget/avatar/stack_avatars.dart';
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
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
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
                      return Column(
                        children: [
                          MogakCard(
                            mogak: controller.meMogaks[index],
                            mogakState: controller.mogakState(
                              controller.meMogaks[index].visiblityStatus,
                            ),
                            isUped: controller
                                .isUped(controller.meMogaks[index].id),
                            controller: controller.toggleLike,
                            title: title,
                          ),
                          const SizedBox(height: 8),
                          StackAvatars(
                            commentLength:
                                controller.meMogaks[index].childrenLength ?? 0,
                            upLength:
                                controller.meMogaks[index].upProfiles.length,
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
