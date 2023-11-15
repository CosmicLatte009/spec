import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import '../../../../controller/talk/me/my_comment_talk_controller.dart';
import '../../../../util/app_color.dart';
import '../../../widget/talk/my_comment_talk_builder.dart';

class MyCommentTalkPage extends GetView<MyCommentTalkController> {
  const MyCommentTalkPage({super.key});
  static const route = '/talk/me/comment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 24),
          const NavMenu(
            title: '내가 쓴 이어달린 톡',
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
                      if (controller.isLoading.isTrue) {
                        return const CircularProgressIndicator();
                      }
                      if (controller.myCommentTalkList.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Text(
                              '아직 내가 쓴 이어달린 톡이 없습니다.',
                              style: AppTextStyles.body14M(
                                  color: AppColor.black60),
                            ),
                          ),
                        );
                      } else {
                        return MyCommentTalkBuilder(
                          commentData: controller.myCommentTalkList,
                          parentTalks: controller.parentTalks,
                          onTalkUpdated: () async {
                            await controller.getMyTalkList();
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
