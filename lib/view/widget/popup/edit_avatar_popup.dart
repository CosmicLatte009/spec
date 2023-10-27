import 'package:flutter/material.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/view/widget/avatar/default_avatar.dart';
import 'package:spec/view/widget/popup/popup.dart';
import 'package:spec/view/widget/tab/custom_tabbar.dart';

class EditAvatarPopup extends StatelessWidget {
  const EditAvatarPopup({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tabList = ["헤어", '피부', '표정', '아이템'];
    List<Widget> tabBarViewList = [
      const Center(child: Text('첫 번째 탭 내용')),
      const Center(child: Text('두 번째 탭 내용')),
      const Center(child: Text('세 번째 탭 내용')),
      const Center(child: Text('네 번째 탭 내용')),
    ];
    return Popup(
      label: '아바타 수정',
      isWide: true,
      child: SizedBox(
        height: 750,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              backgroundColor: AppColor.primary05,
              radius: 60,
              child: DefaultAvatar(
                width: 80,
                hairPosition: -14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 600,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomTabbar(
                  tabList: tabList,
                  tabBarViewList: tabBarViewList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
