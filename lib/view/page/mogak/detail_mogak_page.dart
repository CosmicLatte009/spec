import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak/detail_mogak_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/custom_button.dart';
import 'package:spec/view/widget/card/detail_mogak_card.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';

class DetailMogakPage extends GetView<DetailMogakController> {
  static const route = '/mogak/:id';

  const DetailMogakPage({super.key});
  // final String label; '핫한 모각코', '모든 모각코'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const NavMenu(
              title: '핫한 모각코',
              titleDirection: TitleDirection.center,
            ),
            const SizedBox(height: 24),
            Obx(
              () => controller.detailMogak.value != null
                  ? DetailMogakCard(
                      mogak: controller.detailMogak.value!,
                    )
                  : Container(),
            ),
            //appliedProfiles
            const Row(
              children: [],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomButton(
                text: '참여하기',
                height: 56,
              ),
            ),
            const SizedBox(height: 8),
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
                    //톡 리스트뷰
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColor.black10,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomInput(
                type: InputType.comment,
              ),
            ),
          ),
          CustomBottomNavigationBar(
            currentIndex: 3,
            onTap: (val) {
              print(val);
            },
          ),
        ],
      ),
    );
  }
}
