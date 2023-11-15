import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/hot_mogak_controller.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/widget/button/custom_floating_action_button.dart';
import 'package:spec/view/widget/button/orderby_button.dart';
import 'package:spec/view/widget/card/mogak_card.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/up_and_comment_length.dart';

class HotMogakPage extends GetView<HotMogakController> {
  const HotMogakPage({super.key});
  static const route = '/mogak/hot';
  static const title = '핫한 모각코';

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
                controller.controller.getHotMogak(query: value);
              },
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: ListView(
              children: [
                const NavMenu(
                  title: title,
                  titleDirection: TitleDirection.center,
                ),
                // FilterButton
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
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
                          itemCount: controller.hotMogak!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                MogakCard(
                                  mogak: controller.hotMogak![index],
                                  mogakState: controller.mogakState(controller
                                      .hotMogak![index].visiblityStatus),
                                  isUped: controller
                                      .isUped(controller.hotMogak![index].id),
                                  controller: controller.toggleLike,
                                  title: title,
                                ),
                                const SizedBox(height: 8),
                                UpAndCommentLength(
                                  commentLength: controller
                                          .hotMogak![index].childrenLength ??
                                      0,
                                  upLength: controller
                                      .hotMogak![index].upProfiles.length,
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
