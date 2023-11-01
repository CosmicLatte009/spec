import 'package:flutter/material.dart';
import 'package:spec/view/widget/talk/talk_bubble_builder.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import '../../../util/app_color.dart';
import '../../widget/button/button_circle.dart';

class TalksPage extends StatelessWidget {
  const TalksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButton: CircleButton(
        svg: 'assets/icons/svgs/Community_white.svg',
        iconWidth: 26,
        buttonWidth: 50,
        backColor: AppColor.primary80,
        onTap: () {
          print('호잇');
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (val) {
          print(val);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              child: CustomInput(
                type: InputType.search,
              ),
            ),
            const NavMenu(
              title: '톡톡톡',
              titleDirection: TitleDirection.center,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TalkBubbleBuilder(
                shortName: '플러터/1기',
                nickName: '캐서린',
                contents: '근데 15일차 강의 푸신 분이 어쩌고저쩌고',
                isLikePressed: true,
                isMytalk: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
