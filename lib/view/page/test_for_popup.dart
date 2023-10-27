import 'package:flutter/material.dart';
import 'package:spec/view/widget/popup/profile_popup.dart';
import 'package:spec/view/widget/tab/custom_tabbar.dart';

class TestForPopup extends StatelessWidget {
  const TestForPopup({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tabList = ["헤어", '피부', '표정', '아이템'];
    List<Widget> tabBarViewList = [
      const Center(child: Text('첫 번째 탭 내용')),
      const Center(child: Text('두 번째 탭 내용')),
      const Center(child: Text('세 번째 탭 내용')),
      const Center(child: Text('네 번째 탭 내용')),
    ];
    return Scaffold(
      body: SafeArea(
        child: CustomTabbar(
          tabList: tabList,
          tabBarViewList: tabBarViewList,
        ),
      ),
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       TextButton(
      //         onPressed: () {
      //           showDialog(
      //             context: context,
      //             builder: (context) {
      //               return const ProfilePopup(
      //                 name: '우디',
      //                 role: '수료생',
      //                 position: '개발자 / 1기',
      //               );
      //             },
      //           );
      //         },
      //         child: const Text('popup'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
