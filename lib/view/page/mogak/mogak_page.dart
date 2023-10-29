import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/mogak_controller.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/page/mogak/all_mogak_page.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/top.dart';

class MogakPage extends GetView<MogakController> {
  const MogakPage({super.key});
  static const route = '/mogak';

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
            GestureDetector(
              onTap: () {
                Get.to(const AllMogakPage());
              },
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/pngs/letter.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  '모든 모각코',
                  style: AppTextStyles.body18B(),
                  textAlign: TextAlign.left,
                ),
                trailing: const Icon(
                  Icons.navigate_next,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
