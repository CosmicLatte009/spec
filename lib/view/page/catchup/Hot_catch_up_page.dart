import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spec/model/catchup/catchup.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/navigation/nav_menu.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/card/widget_card.dart';

import '../../../../util/app_color.dart';
import '../../../controller/catchup/catchup_controller.dart';

class HotCatchUp extends GetView<CatchUpController> {
  static const String route = '/catchup/hot';

  const HotCatchUp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.HotCatchup();
    });

    return GestureDetector(
      onHorizontalDragEnd: (dragEndDetails) {
        // 스와이프 방향이 오른쪽으로 갔는지 체크합니다.
        if (dragEndDetails.primaryVelocity! > 0) {
          // 속도가 양수이면 오른쪽으로 스와이프 된 것입니다.
          Navigator.of(context).pop(); // 현재 페이지를 닫습니다.
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: const CustomAppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildSearchTextField(),
                const NavMenu(
                    title: '핫한 캐치업', titleDirection: TitleDirection.center),
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildTabContainer('WEB', 'assets/icons/svgs/SFACE.svg'),
                    _buildTabContainer('APP', 'assets/icons/svgs/SFACE.svg'),
                    _buildTabContainer('GAME', 'assets/icons/svgs/SFACE.svg'),
                    _buildTabContainer('AI', 'assets/icons/svgs/SFACE.svg'),
                    _buildTabContainer('UIUX', 'assets/icons/svgs/SFACE.svg'),
                    _buildTabContainer(
                        'DESIGN', 'assets/catchup_category/Figma.svg'),
                    _buildTabContainer(
                        'SECURITY', 'assets/icons/svgs/SFACE.svg'),
                    _buildTabContainer('ETC', 'assets/icons/svgs/SFACE.svg'),
                    _buildTabContainer(
                        'NEXTJS', 'assets/catchup_category/Next.js.svg'),
                    _buildTabContainer(
                        'PYTHON', 'assets/catchup_category/Python.svg'),
                    _buildTabContainer(
                        'Flutter', 'assets/icons/svgs/Flutter.svg'),
                    _buildTabContainer('DART', 'assets/icons/svgs/Python.svg'),
                    _buildTabContainer(
                        'SOFTWARE', 'assets/icons/svgs/SFACE.svg'),
                    _buildTabContainer(
                        'HARDWARE', 'assets/icons/svgs/SFACE.svg'),
                    _buildTabContainer(
                        'ANDROID', 'assets/catchup_category/Android.svg'),
                    _buildTabContainer(
                        'IOS', 'assets/catchup_category/IOS_Icon.svg'),
                    _buildTabContainer(
                        'JAVA', 'assets/catchup_category/Java.svg'),
                    _buildTabContainer(
                        'KOTLIN', 'assets/catchup_category/Kotlin.svg'),
                    _buildTabContainer(
                        'SWIFT', 'assets/catchup_category/Swift.svg'),
                    _buildTabContainer(
                        'CSHARP', 'assets/catchup_category/C#-(CSharp).svg'),
                    _buildTabContainer(
                        'CPLUS', 'assets/catchup_category/ISO_C++_Logo.svg'),
                    _buildTabContainer('C', 'assets/catchup_category/C.svg'),
                    _buildTabContainer('INFO', 'assets/icons/svgs/SFACE.svg'),
                  ],
                ),
                Obx(() {
                  var hotCatchUpsList = controller.hotCatchUps.value;
                  return _buildHotListView(hotCatchUpsList);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContainer(String? hashTag, String imgUrl) {
    if (hashTag != null && hashTag.isNotEmpty) {
      // 해시태그가 있을 경우
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => InkWell(
            onTap: () {
              controller.setSelectedHashTag(hashTag); // 선택된 해시태그 업데이트
              controller.filterCatchUps(hashTag);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: controller.selectedCategory.value == hashTag
                            ? AppColor.primary40
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(imgUrl) ??
                          SvgPicture.asset('assets/logo/Logo_s.svg'),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    hashTag,
                    style: AppTextStyles.body12B(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      // 해시태그가 없을 경우
      return Container(
        child: const Text('해시태그 없음'),
      );
    }
  }

  ListView _buildHotListView(List<CatchUp> hotCatchUpsList) {
    if (hotCatchUpsList.isEmpty) {
      // 리스트가 비어있을 경우
      return ListView(
        children: const [
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
                  minibadge: catchUp.author?.role ??
                      'null', // 이 필드의 정의가 위에 없으나 예시에 포함됨
                  temperature: catchUp.upProfiles.length.toString(),
                  avatar:
                      catchUp.author?.avatar ?? 'assets/icons/pngs/man-a.png',
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

  void filterAndDisplaySearchResults(String searchText) {
    // Access the value of the Rx object to get the list
    List<CatchUp> searchCatchUps = controller.searchCatchUps.value;

    // Selected category
    String selectedCategory = controller.selectedCategory.value;

    if (selectedCategory.isNotEmpty) {
      // Filter the list based on the selected category and search text
      List<CatchUp> filteredResults = searchCatchUps
          .where((catchUp) =>
              catchUp.category == selectedCategory &&
              (catchUp.title.toLowerCase().contains(searchText.toLowerCase()) ||
                      catchUp.hashtag
                          .toLowerCase()
                          .contains(searchText.toLowerCase()) ??
                  false))
          .toList();

      // Update the value of the Rx object with the filtered results
      controller.filteredCatchUps.value = filteredResults;
    } else {
      // If no category is selected, show all results
      controller.filteredCatchUps.value = searchCatchUps;
    }
  }

  Widget _buildSearchTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Theme(
            data: ThemeData().copyWith(
                scaffoldBackgroundColor: Colors.white,
                colorScheme: ThemeData()
                    .colorScheme
                    .copyWith(primary: AppColor.primary80)),
            child: TextField(
              controller: controller.searchTextcontroller,
              onChanged: (value) {
                if (value.isEmpty) {
                  controller.endSearch();
                }
              },
              onSubmitted: (value) {
                controller.startSearch(value);
              },
              decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: () {
                      controller
                          .startSearch(controller.searchTextcontroller.text);
                    },
                    icon: const Icon(Icons.search)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                hintText: '내용 검색하기',
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.black10),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.primary40),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
