import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/page/me/profile_edit_page.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/logo/splash.svg'),
                  const SizedBox(height: 10),
                  Image.asset('assets/logo/Logo.png'),
                ],
              ),
            ),
            CustomButton(
              text: '로그인',
              height: 56,
              onTap: () {
                Get.toNamed(AppPagesRoutes.login);
              },
            ),
            const SizedBox(height: 114),
          ],
        ),
      ),
    );
  }
}
