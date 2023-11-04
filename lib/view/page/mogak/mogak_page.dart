import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/page/mogak/create_mogak_page.dart';
import 'package:spec/view/widget/avatar/stack_avatars.dart';
import 'package:spec/view/widget/button/custom_floating_action_button.dart';
import 'package:spec/view/widget/card/mogak_card.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';

class MogakPage extends GetView<MogakController> {
  const MogakPage({super.key});
  static const route = '/mogak';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: [
          const SizedBox(
            height: 16,
          ),
          CustomInput(
            type: InputType.search,
            controller: controller.searchController.searchTextController,
            onSubmit: (value) {
              controller.getAllMogak(query: value);
            },
          ),
          NavMenu(
            title: '핫한 모각코',
            titleDirection: TitleDirection.left,
            withEmoji: true,
            emoji: 'assets/icons/pngs/letter.png',
            onButtonPressed: () {
              Get.toNamed(AppPagesRoutes.hotMogak);
            },
          ),
          Obx(
            () => controller.hotMogak != null && controller.hotMogak!.isNotEmpty
                ? Column(
                    children: [
                      MogakCard(
                        mogak: controller.hotMogak!.first,
                        mogakState: controller.getMogakState(
                          controller.hotMogak!.first.visiblityStatus,
                        ),
                        isUped:
                            controller.isUped(controller.hotMogak!.first.id),
                        controller: controller.toggleLike,
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 8),
                          StackAvatars(
                            commentLength:
                                controller.hotMogak![0].appliedProfiles.length,
                            upLength: controller.hotMogak![0].upProfiles.length,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ],
                  )
                : Container(),
          ),
          NavMenu(
            title: '모든 모각코',
            titleDirection: TitleDirection.left,
            withEmoji: true,
            emoji: 'assets/icons/pngs/letter.png',
            onButtonPressed: () {
              Get.toNamed(AppPagesRoutes.allMogak);
            },
          ),
          Obx(
            () => controller.allMogak != null && controller.allMogak!.isNotEmpty
                ? Column(
                    children: [
                      MogakCard(
                        mogak: controller.allMogak!.first,
                        mogakState: controller.getMogakState(
                          controller.allMogak!.first.visiblityStatus,
                        ),
                        isUped:
                            controller.isUped(controller.allMogak!.first.id),
                        controller: controller.toggleLike,
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 8),
                          StackAvatars(
                            commentLength:
                                controller.allMogak![0].appliedProfiles.length,
                            upLength: controller.allMogak![0].upProfiles.length,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ],
                  )
                : Container(),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          // Get.toNamed(AppPagesRoutes.createMogak);
          Get.to(const CreateMogakPage());
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        onTap: (val) {
          print(val);
        },
      ),
    );
  }
}
