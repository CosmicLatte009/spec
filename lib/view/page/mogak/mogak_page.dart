import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/page/mogak/all_mogak_page.dart';
import 'package:spec/view/page/mogak/create_mogak_page.dart';
import 'package:spec/view/page/mogak/hot_mogak_page.dart';
import 'package:spec/view/widget/button/custom_floating_action_button.dart';
import 'package:spec/view/widget/card/mogak_card.dart';
import 'package:spec/view/widget/textEditor/custom_input.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/upAndComent/up_and_comment_length.dart';

class MogakPage extends GetView<MogakController> {
  const MogakPage({super.key});
  static const route = '/mogak';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomInput(
              type: InputType.search,
              controller: controller.searchController.searchTextController,
              onSubmit: (value) {
                controller.getAllMogak(query: value);
              },
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                NavMenu(
                  title: HotMogakPage.title,
                  titleDirection: TitleDirection.left,
                  withEmoji: true,
                  emoji: 'assets/icons/pngs/letter.png',
                  onButtonPressed: () {
                    Get.toNamed(AppPagesRoutes.hotMogak);
                  },
                ),
                Obx(
                  () => controller.hotMogak != null &&
                          controller.hotMogak!.isNotEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: MogakCard(
                                mogak: controller.hotMogak!.first,
                                mogakState: controller.getMogakState(
                                  controller.hotMogak!.first.visiblityStatus,
                                ),
                                isUped: controller
                                    .isUped(controller.hotMogak!.first.id),
                                controller: controller.toggleLike,
                                title: HotMogakPage.title,
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 8),
                                UpAndCommentLength(
                                  commentLength:
                                      controller.hotMogak![0].childrenLength ??
                                          0,
                                  upLength:
                                      controller.hotMogak![0].upProfiles.length,
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ],
                        )
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Text('해당하는 글이 없습니다'),
                          ),
                        ),
                ),
                NavMenu(
                  title: AllMogakPage.title,
                  titleDirection: TitleDirection.left,
                  withEmoji: true,
                  emoji: 'assets/icons/pngs/letter.png',
                  onButtonPressed: () {
                    Get.toNamed(AppPagesRoutes.allMogak);
                  },
                ),
                Obx(
                  () => controller.allMogak != null &&
                          controller.allMogak!.isNotEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: MogakCard(
                                mogak: controller.allMogak!.first,
                                mogakState: controller.getMogakState(
                                  controller.allMogak!.first.visiblityStatus,
                                ),
                                isUped: controller
                                    .isUped(controller.allMogak!.first.id),
                                controller: controller.toggleLike,
                                title: AllMogakPage.title,
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 8),
                                UpAndCommentLength(
                                  commentLength:
                                      controller.allMogak![0].childrenLength ??
                                          0,
                                  upLength:
                                      controller.allMogak![0].upProfiles.length,
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ],
                        )
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Text('해당하는 글이 없습니다'),
                          ),
                        ),
                ),
              ],
            ),
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
