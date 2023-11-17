import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/detail_mogak_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/card/detail_mogak_card.dart';
import 'package:spec/view/widget/textEditor/custom_input.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/talk/comment_talk_builder.dart';

class DetailMogakPage extends GetView<DetailMogakController> {
  static const route = '/mogak/:id';
  static const bottomSheetHeight = 70.0;

  const DetailMogakPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments['title'] ?? '모든 모각코';

    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.only(bottom: bottomSheetHeight),
        children: [
          const SizedBox(height: 24),
          NavMenu(
            title: title,
            titleDirection: TitleDirection.center,
          ),
          const SizedBox(height: 24),
          Obx(
            () => controller.detailMogak.value != null &&
                    controller.userInfo.value != null
                ? DetailMogakCard(
                    userInfo: controller.userInfo.value!,
                    mogak: controller.detailMogak.value!,
                    controller: controller,
                    mogakState: controller.detailMogakState(
                        controller.detailMogak.value!.visiblityStatus),
                    isUped: controller.isUped(controller.detailMogak.value!.id),
                    isLiked: controller.isLiked,
                    isJoined: controller.isJoined,
                    inVisibleButton: title == '내가 만든 그룹',
                  )
                : Container(),
          ),
          const SizedBox(height: 8),
          // 댓글
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/pngs/speaker.png',
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '이어달린 톡',
                        style: AppTextStyles.body18B(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  //톡 리스트뷰
                  Obx(
                    () => CommentTalkBuilder(
                      data: controller.detailMogak.value?.talks ?? [],
                      onTalkUpdated: () async {
                        await controller.getDetailMogak();
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColor.black10,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomInput(
                controller: controller.textEditingController,
                type: InputType.comment,
                onSubmit: (String content) {
                  controller.postNewTalkComment();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
