import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/page/mogak/all_mogak_page.dart';
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
            GestureDetector(
              onTap: () {
                Get.to(const HotMogakPage());
              },
              child: const NavMenu(
                title: '핫한 모각코',
                titleDirection: TitleDirection.left,
                withEmoji: true,
                emoji: 'assets/icons/pngs/letter.png',
              ),
            ),
            Obx(
              () => controller.hotMogak != null &&
                      controller.hotMogak!.isNotEmpty
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
            GestureDetector(
              onTap: () {
                Get.to(const AllMogakPage());
              },
              child: const NavMenu(
                title: '모든 모각코',
                titleDirection: TitleDirection.left,
                withEmoji: true,
                emoji: 'assets/icons/pngs/letter.png',
              ),
            ),
            Obx(
              () => controller.allMogak != null &&
                      controller.hotMogak!.isNotEmpty
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
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {},
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
