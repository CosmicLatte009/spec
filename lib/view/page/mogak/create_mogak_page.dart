import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/create_mogak_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import 'package:spec/view/widget/button/list_button.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/popup/party_number_popup.dart';
import 'package:spec/view/widget/popup/party_state_popup.dart';
import 'package:spec/view/widget/textEditor/custom_multiple_text_editor.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';

class CreateMogakPage extends GetView<CreateMogakController> {
  const CreateMogakPage({super.key});
  static const route = '/mogak/create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          const NavMenu(
            title: '그룹 만들기',
            titleDirection: TitleDirection.center,
          ),
          Expanded(
            child: Column(
              children: [
                CustomMultipleTextEditor(
                  titleController: controller.titleController,
                  contentsController: controller.contentsController,
                  tagsController: controller.tagController,
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppColor.black10,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListButton(
                        text: '모집인원',
                        listType: ListButtonType.setting,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const PartyNumberPopup();
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      ListButton(
                        text: '모집상태',
                        listType: ListButtonType.setting,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const PartyStatePopup();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomButton(
              text: '등록하기',
              height: 56,
              onTap: controller.submitAction,
            ),
          ),
          const SizedBox(height: 37),
        ],
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
