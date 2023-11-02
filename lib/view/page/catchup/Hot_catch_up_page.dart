import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spec/model/catchup.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/page/catchup/catch_up_page.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/widget_card.dart';

import '../../../../util/app_color.dart';
import '../../../controller/catchup_controller.dart';

class HotCatchUp extends GetView<CatchUpController> {

    static const String route = '/catchup/hot';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: CustomAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.fetchCatchUp();
            controller.HotCatchup();
          },
          child: Icon(Icons.refresh),
        ),
        body: Column(
          children: [
            _buildSearchTextField(),
            Expanded(
              flex: 1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildTabContainer('WEB'),
                  _buildTabContainer('APP'),
                  _buildTabContainer('GAME'),
                  _buildTabContainer('AI'),
                  _buildTabContainer('UIUX'),
                  _buildTabContainer('DESIGN'),
                  _buildTabContainer('SECURITY'),
                  _buildTabContainer('ETC'),
                  _buildTabContainer('NEXTJS'),
                  _buildTabContainer('PYTHON'),
                  _buildTabContainer('FLUTTER'),
                  _buildTabContainer('DART'),
                  _buildTabContainer('SOFTWARE'),
                  _buildTabContainer('HARDWARE'),
                  _buildTabContainer('ANDROID'),
                  _buildTabContainer('IOS'),
                  _buildTabContainer('JAVA'),
                  _buildTabContainer('KOTLIN'),
                  _buildTabContainer('SWIFT'),
                  _buildTabContainer('CSHARP'),
                  _buildTabContainer('CPLUS'),
                  _buildTabContainer('C'),
                  _buildTabContainer('INFO'),
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  Get.to(() => CatchUpPage()); // CatchUpPage의 인스턴스 생성
                },
                child: Text('뒤로가기')),
            Expanded(
              flex: 4,
              child: Obx(() {
                var hotCatchUpsList = controller.hotCatchUps.value;
                return _buildHotListView(hotCatchUpsList);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContainer(String? hashTag) {
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
                    child: Icon(Icons.add),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: controller.selectedCategory.value == hashTag
                            ? AppColor.primary40
                            : Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
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
        child: Text('해시태그 없음'),
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
                } else {
                  // 검색어가 변경될 때마다 필터링된 결과 업데이트
                  filterAndDisplaySearchResults(value);
                }
              },
              onSubmitted: (value) {
                controller.startSearch(value);
                // 검색 버튼을 눌렀을 때도 필터링된 결과 업데이트
                filterAndDisplaySearchResults(value);
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      controller
                          .startSearch(controller.searchTextcontroller.text);
                      // 검색 버튼을 눌렀을 때도 필터링된 결과 업데이트
                      filterAndDisplaySearchResults(
                          controller.searchTextcontroller.text);
                    },
                    icon: Icon(Icons.search)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                hintText: '검색하기',
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.black10),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primary40),
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
