import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/me/joined_mogak_controller.dart';
import 'package:spec/view/widget/avatar/stack_avatars.dart';
import 'package:spec/view/widget/button/orderby_button.dart';
import 'package:spec/view/widget/card/mogak_card.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';

class JoinedMogakPage extends GetView<JoinedMogakController> {
  const JoinedMogakPage({super.key});
  static const route = '/mogak/joined';
  static const title = '참여중인 그룹';

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
              children: [
                OrderbyButton(
                  onTap: () {
                    controller.filterController.toggleOrderBy();
                    controller.getJoinedMogak();
                  },
                ),
                const SizedBox(height: 24),
                Obx(
                  () => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.joinedMogaks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          MogakCard(
                            mogak: controller.joinedMogaks[index],
                            mogakState: controller.mogakState(
                              controller.joinedMogaks[index].visiblityStatus,
                            ),
                            isUped: controller
                                .isUped(controller.joinedMogaks[index].id),
                            controller: controller.toggleLike,
                            title: title,
                          ),
                          const SizedBox(height: 8),
                          StackAvatars(
                            commentLength:
                                controller.joinedMogaks[index].childrenLength ??
                                    0,
                            upLength: controller
                                .joinedMogaks[index].upProfiles.length,
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
