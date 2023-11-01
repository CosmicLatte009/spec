import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spec/controller/Home_controller.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/widget_best_spacer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.toInt() + 1;
        if (nextPage == controller.allCourse.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  HomeController get controller => Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.fetchHomeData();
          controller.fetchBestSpacerData();
        },
        child: Icon(Icons.refresh),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Obx(() {
            if (controller.allCourse.isEmpty) {
              return Center(child: Text('No courses available.'));
            }
            return Column(
              children: [
                Container(
                  height: 150,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.allCourse.length,
                    itemBuilder: (context, index) {
                      var course = controller.allCourse[index];
                      return course.thumbnail != null
                          ? Image.network(course.thumbnail, fit: BoxFit.cover)
                          : Container();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: controller.allCourse.length,
                  effect: WormEffect(
                    dotHeight: 5,
                    dotWidth: 5,
                    spacing: 4,
                    activeDotColor: Colors.blue,
                  ),
                ),
              ],
            );
          }),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomInput(type: InputType.search),
          ),
          NavMenu(title: '핫한 톡', titleDirection: TitleDirection.left),
          Container(height: 202),
          NavMenu(title: '핫한 캐치업', titleDirection: TitleDirection.left),
          Container(height: 202),
          NavMenu(title: '핫한 모각코', titleDirection: TitleDirection.left),
          Container(height: 255),
          NavMenu(title: '이달의 스페이서', titleDirection: TitleDirection.left),
          BestSpacerWidget(),
        ],
      ),
    );
  }
}
