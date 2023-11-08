import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/all_mogak_controller.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/widget/avatar/stack_avatars.dart';
import 'package:spec/view/widget/button/custom_floating_action_button.dart';
import 'package:spec/view/widget/button/orderby_button.dart';
import 'package:spec/view/widget/card/mogak_card.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';

class AllMogakPage extends GetView<AllMogakController> {
  const AllMogakPage({super.key});
  static const route = '/mogak/all';
  static const title = '모든 모각코';

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
                controller.controller.getAllMogak(query: value);
              },
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: ListView(
              children: [
                //이전페이지 네비게이션
                const NavMenu(
                  title: title,
                  titleDirection: TitleDirection.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      // FilterButton
                      OrderbyButton(
                        onTap: () {
                          controller.filterController.toggleOrderBy();
                          controller.controller.getAllMogak();
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      //모각코 카드
                      Obx(
                        () => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.allMogak!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                MogakCard(
                                  mogak: controller.allMogak![index],
                                  mogakState: controller.mogakState(
                                    controller.allMogak![index].visiblityStatus,
                                  ),
                                  isUped: controller
                                      .isUped(controller.allMogak![index].id),
                                  controller: controller.toggleLike,
                                  title: title,
                                ),
                                const SizedBox(height: 8),
                                StackAvatars(
                                  commentLength: controller
                                          .allMogak![index].childrenLength ??
                                      0,
                                  upLength: controller
                                      .allMogak![index].upProfiles.length,
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
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Get.toNamed(AppPagesRoutes.createMogak);
        },
      ),
    );
  }
}
