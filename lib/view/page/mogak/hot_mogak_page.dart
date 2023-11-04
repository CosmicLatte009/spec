import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/hot_mogak_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/widget/avatar/stack_avatars.dart';
import 'package:spec/view/widget/button/custom_floating_action_button.dart';
import 'package:spec/view/widget/card/mogak_card.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';

class HotMogakPage extends GetView<HotMogakController> {
  const HotMogakPage({super.key});
  static const route = '/mogak/hot';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            const CustomInput(
              type: InputType.search,
            ),
            //이전페이지 네비게이션
            const NavMenu(
              title: '핫한 모각코',
              titleDirection: TitleDirection.center,
            ),
            // FilterButton
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/icons/svgs/Filter.svg',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    '날짜순',
                    style: TextStyle(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            //모각코 카드
            Expanded(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.hotMogak!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MogakCard(
                          mogak: controller.hotMogak![index],
                          mogakState: controller.mogakState(
                              controller.hotMogak![index].visiblityStatus),
                          isUped:
                              controller.isUped(controller.hotMogak![index].id),
                          controller: controller.toggleLike,
                        ),
                        const SizedBox(height: 8),
                        StackAvatars(
                          commentLength: controller
                              .hotMogak![index].appliedProfiles.length,
                          upLength:
                              controller.hotMogak![index].upProfiles.length,
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Get.toNamed(AppPagesRoutes.createMogak);
        },
      ),
    );
  }
}
