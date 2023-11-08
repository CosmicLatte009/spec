// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/button_circle.dart';
import 'package:spec/view/widget/popup/talk_editing_popup.dart';
import 'package:spec/view/widget/talk/talk_bubble_builder.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import '../../../controller/talk/main_talk_controller.dart';
import '../../../model/talk.dart';
import '../../../util/app_color.dart';
import '../../../util/app_page_routes.dart';

class MainTalkPage extends StatefulWidget {
  const MainTalkPage({super.key});
  static const route = '/talk/main';

  @override
  State<MainTalkPage> createState() => _MainTalkPageState();
}

class _MainTalkPageState extends State<MainTalkPage> {
  final MainTalkController controller = Get.find();
  TextEditingController textEditingController = TextEditingController();

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
          setState(
            () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return TalkEditingPopup(
                      controller: textEditingController, //@todo: 톡 생성하기
                      onSubmit: () {
                        print(textEditingController
                            .text); //@todo: controller로부터 고유id만 갖는(content만 보내는) POST 함수 호출;
                      },
                    );
                  });
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (val) {
          print(val);
        },
      ),
      body: Obx(() {
        if (controller.mainTalksLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
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
                      NavMenu(
                        title: '핫한 톡',
                        titleDirection: TitleDirection.left,
                        withEmoji: true,
                        onButtonPressed: () =>
                            Get.toNamed(AppPagesRoutes.hotTalk),
                      ),
                      const SizedBox(height: 16),
                      _buildHotTalkSection(),
                      const SizedBox(height: 26),
                      NavMenu(
                        title: '톡톡톡',
                        titleDirection: TitleDirection.left,
                        withEmoji: true,
                        onButtonPressed: () =>
                            Get.toNamed(AppPagesRoutes.allTalk),
                      ),
                      _buildAllTalkSection(),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _buildHotTalkSection() {
    if (controller.hotTalks.isNotEmpty) {
      var hotTalk = controller.hotTalks.sublist(0, 1);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TalkBubbleBuilder(data: RxList<Talk>.from(hotTalk)),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text('현재 핫한 톡이 없습니다.', style: AppTextStyles.body14M()),
      );
    }
  }

  Widget _buildAllTalkSection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TalkBubbleBuilder(data: controller.allTalks),
    );
  }
}
