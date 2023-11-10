import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/talk/detail_talk_controller.dart';
import 'package:spec/model/talk.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import '../../widget/avatar/user_avatar.dart';
import '../../widget/navigation/top.dart';
import '../../widget/talk/talk_bubble.dart';
import '../../widget/talk/comment_talk_builder.dart';

class DetailTalkPage extends GetView<DetailTalkController> {
  const DetailTalkPage({super.key});
  static const route = '/talk/detail/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Obx(() {
        if (controller.isDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.detailTalk == null) {
          return const Center(child: Text('톡 내용을 불러올 수 없습니다.'));
        } else {
          Talk talk = controller.detailTalk!;
          return SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: NavMenu(
                    title: '톡 상세보기',
                    titleDirection: TitleDirection.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserAvatar(
                        avatarUrl: talk.author.avatar,
                        direction: BadgeDirection.column,
                        shortName: talk.author.badge?.shortName,
                        nickName: talk.author.nickname,
                      ),
                      const SizedBox(width: 17.02),
                      TalkBubble(
                        talk: talk,
                        type: BubbleType.detail,
                        // mytalk: true,
                        onTapEnabled: false,
                        onTalkUpdated: () async {
                          await controller.getTalkById();
                          await controller.getAllTalks();
                          await controller.getHotTalks();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.only(top: 14, bottom: 16),
                  color: AppColor.white,
                  child: Column(
                    children: [
                      const NavMenu(
                        title: '이어달린 톡',
                        titleDirection: TitleDirection.left,
                        withEmoji: true,
                        withIconButton: false,
                        emoji: 'assets/icons/pngs/speaker.png',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CommentTalkBuilder(
                          data: controller.commentTalks,
                          onTalkUpdated: () async {
                            await controller.getTalkById();
                            await controller.getAllTalks();
                            await controller.getHotTalks();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 113),
              ],
            ),
          );
        }
      }),
      bottomSheet: Container(
        padding: const EdgeInsets.all(10.0),
        height: 70,
        decoration: const BoxDecoration(
          color: AppColor.white,
          border: Border(
            top: BorderSide(
              color: AppColor.back05,
              width: 2,
            ),
          ),
        ),
        child: CustomInput(
          controller: controller.textEditingController,
          type: InputType.comment,
          onSubmit: (String content) {
            controller.postNewTalkComment();
          },
        ),
      ),
    );
  }
}
