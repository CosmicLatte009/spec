import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/talk/hot_talk_controller.dart';
import 'package:spec/view/widget/talk/talk_bubble_builder.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import '../../../util/app_color.dart';
import '../../widget/button/button_circle.dart';

class HotTalkPage extends GetView<HotTalkController> {
  const HotTalkPage({super.key});
  static const route = '/talk/hot';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButton: CircleButton(
        svg: 'assets/icons/svgs/Community_white.svg',
        iconWidth: 26,
        backColor: AppColor.primary80,
        buttonWidth: 50,
        onTap: () {
          print('호잇');
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (val) {
          print(val);
        },
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
            child: CustomInput(
              type: InputType.search,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const NavMenu(
                    title: '핫한 톡',
                    titleDirection: TitleDirection.center,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const CircularProgressIndicator();
                      } else {
                        return TalkBubbleBuilder(
                          data: controller.hotTalks,
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
