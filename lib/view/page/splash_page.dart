import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spec/view/page/login_page.dart';
import 'package:spec/view/widget/button/button_xlarge.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                SvgPicture.asset('assets/logo/splash.svg'),
                const SizedBox(height: 10),
                Image.asset('assets/logo/Logo.png'),
                const SizedBox(height: 150),
                ButtonXlarge(
                  text: '시작하기',
                  onTap: () {
                    Get.to(() => LoginScreen());
                  },
                ),
              ],
            ),
          )),
    );
  }
}
