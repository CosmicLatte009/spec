import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/page/mogak/all_mogak_page.dart';
import 'package:spec/view/page/mogak/create_mogak_page.dart';
import 'package:spec/view/page/mogak/hot_mogak_page.dart';
import 'package:spec/view/widget/button/custom_floating_action_button.dart';
import 'package:spec/view/widget/card/card_seperator.dart';
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
          const CustomInput(
            type: InputType.search,
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
                      MogakCard(mogak: controller.hotMogak!.first),
                      Column(
                        children: [
                          CardSeperator(mogak: controller.hotMogak!.first),
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
            () => controller.allMogak != null && controller.hotMogak!.isNotEmpty
                ? Column(
                    children: [
                      MogakCard(mogak: controller.allMogak!.first),
                      Column(
                        children: [
                          CardSeperator(mogak: controller.allMogak!.first),
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
