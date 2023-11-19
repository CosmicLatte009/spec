import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spec/controller/me/my_page_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/page/auth/change_password_page.dart';
import 'package:spec/view/page/me/profile_edit_page.dart';
import 'package:spec/view/widget/alert/300_width/with_two_button.dart';
import 'package:spec/view/widget/avatar/user_avatar.dart';
import 'package:spec/view/widget/button/list_button.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';

class MyPage extends GetView<MyPageController> {
  static const route = '/mypage';

  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 4,
          onTap: (values) => print(values),
        ),
        appBar: const CustomAppBar(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 370,
                height: 420,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(width: 1, color: const Color(0xFFE6E6E6))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => controller.userInfo != null
                          ? UserAvatar(
                              avatarUrl: controller.userInfo!.avatar,
                              avatarSize: AvatarSize.w60,
                              shortName: controller.userInfo!.badge?.shortName,
                              nickName: controller.userInfo!.nickname,
                              direction: BadgeDirection.column,
                              role: controller.userInfo!.role,
                            )
                          : const UserAvatar(),
                    ),
                    const SizedBox(height: 20),
                    SvgPicture.asset(
                      'assets/icons/svgs/Bottom_dot.svg',
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/pngs/laptop.png',
                            ),
                            Text(
                              '스페이서 달성',
                              style: AppTextStyles.body18B(
                                  color: AppColor.black80),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                      Icons.arrow_back_ios_new_outlined)),
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  Container(
                                      width: 34,
                                      height: 22,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF3F3F3),
                                      ),
                                      child: Center(
                                        child: Text('1월',
                                            style: AppTextStyles.body12R(
                                                color: AppColor.black60)),
                                      )),
                                  const SizedBox(height: 5),
                                  Image.asset('assets/icons/pngs/No.png'),
                                  Row(
                                    children: [
                                      const Icon(Icons.favorite,
                                          color: Color(0xFFE6E6E6)),
                                      Text('',
                                          style: AppTextStyles.body12R(
                                              color: AppColor.primary80)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Column(
                                children: [
                                  Container(
                                      width: 34,
                                      height: 22,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF3F3F3),
                                      ),
                                      child: Center(
                                        child: Text('1월',
                                            style: AppTextStyles.body12R(
                                                color: AppColor.black60)),
                                      )),
                                  const SizedBox(height: 5),
                                  Image.asset('assets/icons/pngs/1st.png'),
                                  Row(
                                    children: [
                                      const Icon(Icons.favorite,
                                          color: Colors.red),
                                      Text('400',
                                          style: AppTextStyles.body12R(
                                              color: AppColor.primary80)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Column(
                                children: [
                                  Container(
                                      width: 34,
                                      height: 22,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF3F3F3),
                                      ),
                                      child: Center(
                                        child: Text('1월',
                                            style: AppTextStyles.body12R(
                                                color: AppColor.black60)),
                                      )),
                                  const SizedBox(height: 5),
                                  Image.asset('assets/icons/pngs/1st.png'),
                                  Row(
                                    children: [
                                      const Icon(Icons.favorite,
                                          color: Colors.red),
                                      Text('400',
                                          style: AppTextStyles.body12R(
                                              color: AppColor.primary80)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_outlined)),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

            ///////////////////////////////////////////////////////
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    width: 370,
                    height: 246,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1, color: const Color(0xFFE6E6E6))),
                    child: Column(children: [
                      const SizedBox(height: 21),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: NavMenu(
                          withEmoji: true,
                          withIconButton: false,
                          title: '나의 톡!',
                          titleDirection: TitleDirection.left,
                        ),
                      ),
                      SizedBox(
                        width: 324,
                        height: 150,
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListButton(
                                text: '내가 쓴 톡',
                                listType: ListButtonType.setting,
                                onTap: () {
                                  Get.toNamed(AppPagesRoutes.myTalk);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListButton(
                                text: '좋아요 한 톡',
                                listType: ListButtonType.setting,
                                onTap: () {
                                  Get.toNamed(AppPagesRoutes.myUpTalk);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListButton(
                                text: '내가 쓴 이어달린 톡',
                                listType: ListButtonType.setting,
                                onTap: () {
                                  Get.toNamed(AppPagesRoutes.myCommentTalk);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]))),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    width: 370,
                    height: 190,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1, color: const Color(0xFFE6E6E6))),
                    child: Column(children: [
                      const SizedBox(height: 21),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: NavMenu(
                          withEmoji: true,
                          withIconButton: false,
                          title: '나의 캐치업!',
                          emoji: 'assets/icons/pngs/dart.png',
                          titleDirection: TitleDirection.left,
                        ),
                      ),
                      SizedBox(
                        width: 324,
                        height: 101,
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListButton(
                                text: '내 캐치업',
                                listType: ListButtonType.setting,
                                onTap: () {
                                  Get.to(const ChangePasswordPage());
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListButton(
                                text: '좋아요 한 캐치업',
                                listType: ListButtonType.setting,
                                onTap: () {
                                  Get.to(const ChangePasswordPage());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]))),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    width: 370,
                    height: 190,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1, color: const Color(0xFFE6E6E6))),
                    child: Column(children: [
                      const SizedBox(height: 21),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: NavMenu(
                          withEmoji: true,
                          withIconButton: false,
                          title: '나의 모각코!',
                          emoji: 'assets/icons/pngs/letter.png',
                          titleDirection: TitleDirection.left,
                        ),
                      ),
                      SizedBox(
                        width: 324,
                        height: 101,
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListButton(
                                text: '내가 만든 그룹',
                                listType: ListButtonType.setting,
                                onTap: () {
                                  Get.toNamed(AppPagesRoutes.meMogak);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListButton(
                                text: '참여중인 그룹',
                                listType: ListButtonType.setting,
                                onTap: () {
                                  Get.toNamed(AppPagesRoutes.joinedMogak);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]))),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    width: 370,
                    height: 295,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1, color: const Color(0xFFE6E6E6))),
                    child: Column(children: [
                      const SizedBox(height: 21),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: NavMenu(
                          withEmoji: true,
                          withIconButton: false,
                          title: '설정',
                          emoji: 'assets/icons/pngs/_Setting.png',
                          titleDirection: TitleDirection.left,
                        ),
                      ),
                      SizedBox(
                        width: 324,
                        height: 229,
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListButton(
                                text: '내 정보 수정하기',
                                listType: ListButtonType.setting,
                                onTap: () {
                                  Get.to(const ProfileEditPage());
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListButton(
                                text: '비밀번호 변경',
                                listType: ListButtonType.setting,
                                onTap: () {
                                  Get.to(const ChangePasswordPage());
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListButton(
                                text: '로그아웃',
                                listType: ListButtonType.setting,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return WithTwoButton(
                                            button1: '취소하기',
                                            button2: '로그아웃',
                                            message: '정말 로그아웃 하시겠습니까?',
                                            callback2: () {
                                              controller.authController
                                                  .logout();
                                            });
                                      });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListButton(
                                text: '회원 탈퇴',
                                listType: ListButtonType.setting,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return WithTwoButton(
                                            button1: '취소하기',
                                            button2: '탈퇴하기',
                                            message: '회원탈퇴를 하시겠습니까?',
                                            callback2: controller
                                                .authController.deleteAccount);
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]))),
          ],
        ));
  }
}
