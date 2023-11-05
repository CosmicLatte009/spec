import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spec/controller/Home_controller.dart';
import 'package:spec/model/catchup.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/page/best_spacer/best_spacer_page.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/widget_best_spacer.dart';
import 'package:spec/view/widget/widget_card.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

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
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (val) {
          print(val);
        },
      ),
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
          NavMenu(
            title: '핫한 톡',
            titleDirection: TitleDirection.left,
            onButtonPressed: () {
              Get.toNamed(AppPagesRoutes.hotTalk);
            },
          ),
          Container(height: 202),
          NavMenu(
            title: '핫한 캐치업',
            titleDirection: TitleDirection.left,
            onButtonPressed: () {
              Get.toNamed(AppPagesRoutes.catchUp);
            },
          ),
          Expanded(
            flex: 4,
            child: Obx(() {
              var hotCatchUpsList = controller.hotCatchUps.value;
              return _buildHotListView(hotCatchUpsList);
            }),
          ),
          NavMenu(
            title: '핫한 모각코',
            titleDirection: TitleDirection.left,
            onButtonPressed: () {
              Get.toNamed(AppPagesRoutes.hotMogak);
            },
          ),
          Container(height: 255),
          NavMenu(
              title: '이달의 스페이서',
              titleDirection: TitleDirection.left,
              onButtonPressed: () => Get.to(BestSpacerPage())),
          BestSpacerWidgetHome(),
        ],
      ),
    );
  }
}

ListView _buildHotListView(List<CatchUp> hotCatchUpsList) {
  if (hotCatchUpsList.isEmpty) {
    // 리스트가 비어있을 경우
    return ListView(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text('해당하는 글이 없습니다'),
          ),
        ),
      ],
    );
  } else {
    // 리스트에 데이터가 있을 경우
    return ListView.builder(
      itemCount: hotCatchUpsList.length,
      itemBuilder: (context, index) {
        final catchUp = hotCatchUpsList[index];
        // String을 DateTime으로 변환
        final createdAtDate = DateTime.parse(catchUp.createdAt);
        final dateOnly = DateTime(
            createdAtDate.year, createdAtDate.month, createdAtDate.day);
        final formattedDate = DateFormat('yyyy.MM.dd').format(dateOnly);

        return Padding(
          padding: const EdgeInsets.all(.0),
          child: Column(
            children: [
              CardWidget(
                minibadge:
                    catchUp.author?.role ?? 'null', // 이 필드의 정의가 위에 없으나 예시에 포함됨
                temperature: catchUp.upProfiles.length.toString(),
                avatar: catchUp.author?.avatar ?? 'assets/icons/pngs/man-a.png',
                position: catchUp.author?.badge!.shortName ??
                    'Unknown Position', // 기본값 예시
                nickname: catchUp.author?.nickname ?? 'null',
                url: catchUp.url,
                hashTags: catchUp.hashtag ?? '태그가 없어요 ㅠㅠ',
                thumbnail: catchUp.thumbnail,
                description: catchUp.title,
                createdTime: formattedDate,
                postId: catchUp.id,
              ),
            ],
          ),
        );
      },
    );
  }
}
