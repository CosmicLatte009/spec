import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/profile_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/avatar/default_avatar.dart';
import 'package:spec/view/widget/avatar/large_avatar.dart';
import 'package:spec/view/widget/avatar/user_avatar.dart';
import 'package:spec/view/widget/button/button_circle.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/popup/edit_avatar_popup.dart';
import 'package:spec/view/widget/select/custom_radio_group.dart';

class ProfileEditPage extends GetView<ProfileController> {
  const ProfileEditPage({super.key});
  static const route = '/profile/edit';

  @override
  Widget build(BuildContext context) {
    List position = ['개발자', '디자이너', '헤드헌터'];
    //@todo 프로필 수정 페이지
    // 1. 기존 유저 정보 가져오기. 정보가 있다면 기존 회원이므로
    // 2. 닉네임은 수정할 수 없도록 하기.
    // print(controller.authController.myProfile.value?.avatar);
    // print('curAvatar: ${controller.curAvatar.value}');

    return Scaffold(
        appBar: const CustomAppBar(),
        body: ListView(
          children: [
            const SizedBox(height: 89),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColor.black10,
                      ),
                    ),
                    width: 370,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //아바타
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            //inputs
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Text(
                                    '*표시는 필수입력항목입니다.',
                                    textAlign: TextAlign.right,
                                    style: AppTextStyles.body8R(
                                      color: AppColor.warning,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: CustomInput(
                                    label: '닉네임',
                                    hint: '닉네임을 입력해주세요.',
                                    isRequired: true,
                                    controller: controller.nicknameController,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            '활동유형',
                                            textAlign: TextAlign.start,
                                            style: AppTextStyles.body14M(),
                                          ),
                                          Text(
                                            '*',
                                            style: AppTextStyles.body14M(
                                                color: AppColor.warning),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Obx(
                                      () => CustomRadioGroup(
                                        items: position,
                                        selectedIndex: controller.selectedIndex,
                                        onItemSelect: (index) {
                                          controller.updateIndex(index);
                                        },
                                        direction: Axis.horizontal,
                                        itemSpacing: 0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Column(
                                    children: [
                                      CustomInput(
                                        label: '링크 추가',
                                        hint: 'LinkedIn URL',
                                      ),
                                      SizedBox(height: 8),
                                      CustomInput(
                                        hint: 'Github URL',
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomInput(
                                              hint: '개인 웹사이트 URL',
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: CustomInput(
                                              hint: '개인 웹사이트 URL',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      onTap: controller
                                          .avatarController.resetAvatar,
                                      text: '초기화',
                                      type: ButtonType.outline,
                                      height: 40,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: CustomButton(
                                      onTap: controller.withAuth
                                          ? controller.uploadProfile
                                          : controller.createProfile,
                                      text:
                                          controller.withAuth ? '수정하기' : '저장하기',
                                      height: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -70,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColor.primary05,
                          child: Opacity(
                            opacity: 0.2,
                            child: controller.authController.myProfile.value !=
                                    null
                                ? LargeAvatar(
                                    //서버로부터 받은 이미지 주소. @todo: 아바타 수정시 수정된 아바타 이미지를 띄워야 함
                                    avatarUrl: controller.avatar != null
                                        ? controller.avatar!
                                        : controller.authController.myProfile
                                            .value!.avatar!,
                                  )
                                : const DefaultAvatar(
                                    width: 200,
                                  ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const EditAvatarPopup();
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '아바타 수정하기',
                              style: AppTextStyles.body12R(
                                color: AppColor.primary80,
                              ),
                            ),
                            const SizedBox(width: 8),
                            CircleButton(
                              svg: 'assets/icons/svgs/edit.svg',
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const EditAvatarPopup();
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
              ],
            ),
          ],
        ));
  }
}
