import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spec/controller/Home_controller.dart';
import 'package:spec/controller/mogak/mogak_controller.dart';
import 'package:spec/model/catchup.dart';
import 'package:spec/util/app_page_routes.dart';
import 'package:spec/view/page/best_spacer/best_spacer_page.dart';
import 'package:spec/view/page/mogak/hot_mogak_page.dart';
import 'package:spec/view/widget/avatar/stack_avatars.dart';
import 'package:spec/view/widget/card/mogak_card.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/navigation/bottomnavigationbar.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/widget_best_spacer_home.dart';
import 'package:spec/view/widget/widget_card.dart';
import '../../controller/talk/talk_controller.dart';
import '../../model/talk.dart';
import '../../util/app_text_style.dart';
import '../widget/talk/talk_bubble_builder.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

  const HomePage({super.key});

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
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page?.toInt() ?? 0 + 1;
        if (nextPage >= controller.allCourse.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  HomeController get controller => Get.find<HomeController>();
  MogakController get mogakController => Get.find<MogakController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (val) {
          print(val);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (controller.allCourse.isEmpty) {
                return const Center(child: Text('No courses available.'));
              }
              return Column(
                children: [
                  SizedBox(
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
                  const SizedBox(
                    height: 10,
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: controller.allCourse.length,
                    effect: const WormEffect(
                      dotHeight: 5,
                      dotWidth: 5,
                      spacing: 4,
                      activeDotColor: Colors.blue,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomInput(type: InputType.search),
            ),
            NavMenu(
              title: '핫한 톡',
              withEmoji: true,
              titleDirection: TitleDirection.left,
              onButtonPressed: () {
                Get.toNamed(AppPagesRoutes.hotTalk);
              },
            ),
           _buildHotTalkSection(),
            NavMenu(
              title: '핫한 캐치업',
              withEmoji: true,
              titleDirection: TitleDirection.left,
              onButtonPressed: () {
                Get.toNamed(AppPagesRoutes.catchUp);
              },
            ),
            Obx(() {
              var homeHotCatchUpsList = controller.HomeHotCatchUps.value;
              return _buildHotListView(homeHotCatchUpsList);
            }),
            NavMenu(
              title: '핫한 모각코',
              withEmoji: true,
              titleDirection: TitleDirection.left,
              onButtonPressed: () {
                Get.toNamed(AppPagesRoutes.hotMogak);
              },
            ),
            Obx(
              () => mogakController.hotMogak != null &&
                      mogakController.hotMogak!.isNotEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: MogakCard(
                            mogak: mogakController.hotMogak!.first,
                            mogakState: mogakController.getMogakState(
                              mogakController.hotMogak!.first.visiblityStatus,
                            ),
                            isUped: mogakController
                                .isUped(mogakController.hotMogak!.first.id),
                            controller: mogakController.toggleLike,
                            title: HotMogakPage.title,
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            StackAvatars(
                              commentLength:
                                  mogakController.hotMogak![0].childrenLength ??
                                      0,
                              upLength: mogakController
                                  .hotMogak![0].upProfiles.length,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ],
                    )
                  : Container(),
            ),
            NavMenu(
              title: '이달의 스페이서',
              titleDirection: TitleDirection.left,
              onButtonPressed: () => Get.to(BestSpacerPage()),
            ),
            BestSpacerWidgetHome(),
          ],
        ),
      ),
    );
  }

  Widget _buildHotListView(List<CatchUp> hotCatchUpsList) {
    if (hotCatchUpsList.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text('해당하는 글이 없습니다'),
        ),
      );
    } else {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(), // 중첩된 스크롤을 막기 위해
        shrinkWrap: true, // ListView가 자신의 컨텐츠 크기에 맞게 크기를 조정하도록 함
        itemCount: hotCatchUpsList.length,
        itemBuilder: (context, index) {
          final catchUp = hotCatchUpsList[0];
          final createdAtDate = DateTime.parse(catchUp.createdAt);
          final dateOnly = DateTime(
              createdAtDate.year, createdAtDate.month, createdAtDate.day);
          final formattedDate = DateFormat('yyyy.MM.dd').format(dateOnly);

          return CardWidget(
            minibadge: catchUp.author?.role ?? 'null',
            temperature: catchUp.upProfiles.length.toString(),
            avatar: catchUp.author?.avatar ?? 'assets/icons/pngs/man-a.png',
            position: catchUp.author?.badge!.shortName ?? 'Unknown Position',
            nickname: catchUp.author?.nickname ?? 'null',
            url: catchUp.url,
            hashTags: catchUp.hashtag ?? '태그가 없어요 ㅠㅠ',
            thumbnail: catchUp.thumbnail,
            description: catchUp.title,
            createdTime: formattedDate,
            postId: catchUp.id,
          );
        },
      );
    }
  }
}
