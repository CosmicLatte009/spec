import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import '../../../../controller/talk/me/my_up_talk_controller.dart';
import '../../../../util/app_color.dart';
import '../../../widget/talk/talk_bubble_builder.dart';

class MyUpTalkPage extends GetView<MyUpTalkController> {
  const MyUpTalkPage({super.key});
  static const route = '/talk/me/up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 24),
          const NavMenu(
            title: '좋아요 한 톡',
            titleDirection: TitleDirection.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Row(children: [
                      SvgPicture.asset(
                        'assets/icons/svgs/Filter.svg',
                        width: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '날짜순',
                        style: AppTextStyles.body12M(color: AppColor.primary80),
                      )
                    ])),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const CircularProgressIndicator();
                      } else {
                        return TalkBubbleBuilder(
                          data: controller.myUpTalkList,
                          onTalkUpdated: () async {
                            await controller.getAllTalks();
                            await controller.getHotTalks();
                            await controller.getMyUpTalkList();
                          },
                        );
                      }
                    }),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
