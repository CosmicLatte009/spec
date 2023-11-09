import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/update_mogak_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import 'package:spec/view/widget/button/list_button.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/popup/party_number_popup.dart';
import 'package:spec/view/widget/popup/party_state_popup.dart';
import 'package:spec/view/widget/textEditor/custom_multiple_text_editor.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';

class UpdateMogakPage extends GetView<UpdateMogakController> {
  const UpdateMogakPage({super.key});
  static const route = '/mogak/update/:id';
  static const visiblityStatus = ['작성중', '모집중', '모집완료'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          const NavMenu(
            title: '그룹 수정하기',
            titleDirection: TitleDirection.center,
          ),
          Expanded(
            child: Column(
              children: [
                CustomMultipleTextEditor(
                  titleController: controller.titleController,
                  contentsController: controller.contentsController,
                  tagsController: controller.tagsController,
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
                      Obx(
                        () => controller.maxMemberAsString.isNotEmpty
                            ? ListButton(
                                text: '모집인원',
                                listType: ListButtonType.recruitCount,
                                count: controller.maxMember,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const PartyNumberPopup();
                                    },
                                  );
                                },
                              )
                            : ListButton(
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
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => controller.selectedIndex.value != -1
                            ? ListButton(
                                text: '모집상태',
                                recruitState: visiblityStatus[
                                    controller.selectedIndex.value],
                                listType: ListButtonType.recruitState,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const PartyStatePopup(
                                        items: visiblityStatus,
                                      );
                                    },
                                  );
                                },
                              )
                            : ListButton(
                                text: '모집상태',
                                listType: ListButtonType.setting,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const PartyStatePopup(
                                        items: visiblityStatus,
                                      );
                                    },
                                  );
                                },
                              ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomButton(
              text: '수정하기',
              height: 56,
              onTap: () async {
                await controller.updateMogak();
                // if (validateInputs()) {
                //   await controller.updateMogak();
                // }
              },
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
