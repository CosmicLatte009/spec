import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/page/mogak/mogak_page.dart';
import 'package:spec/view/widget/card/card_seperator.dart';
import 'package:spec/view/widget/card/mogak_card.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';

class AllMogakPage extends GetView<MogakController> {
  const AllMogakPage({super.key});
  static const route = '/mogak/all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            const CustomInput(
              type: InputType.search,
            ),
            //이전페이지 네비게이션
            const NavMenu(
              title: '모든 모각코',
              titleDirection: TitleDirection.center,
            ),
            // FilterButton
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/icons/svgs/Filter.svg',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    '날짜순',
                    style: TextStyle(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            //모각코 카드
            Expanded(
              child: Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.allMogak!.length ?? 0,
                  itemBuilder: (context, index) {
                    return MogakCard(mogak: controller.allMogak![index]);
                  },
                  separatorBuilder: (context, index) {
                    return Column(
                      children: [
                        CardSeperator(mogak: controller.allMogak![index]),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
