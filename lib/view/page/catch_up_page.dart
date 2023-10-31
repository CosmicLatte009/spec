import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/model/catchup.dart';
import 'package:spec/view/widget/navigation/top.dart';
import 'package:spec/view/widget/widget_card.dart';
import '../../controller/catchup_controller.dart';
import 'package:intl/intl.dart';
import '../../model/Author.dart';
import 'Hot_catch_up_page.dart';
import '../../../util/app_color.dart';

// 'CatchUpPage' 클래스는 캐치업 페이지를 나타냄
class CatchUpPage extends GetView<CatchUpController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: CustomAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // 새로고침 버튼 누를 때 데이터 새로 가져옴
            controller.fetchCatchUp();
            controller.HotCatchup();
          },
          child: Icon(Icons.refresh),
        ),
        body: Column(
          children: [
            _buildSearchTextField(), // 검색 필드 구성
            TextButton(
                onPressed: () {
                  Get.to(HotCatchUp());
                },
                child: Text('핫한 캐치업')),
            _buildHotCatchUpsSection(), // '핫한 캐치업' 섹션 구성
            TextButton(onPressed: () {}, child: Text('캐치업')),

            _buildFlexibleCatchUpsListView(), // 주요 캐치업 리스트뷰 구성
          ],
        ),
      ),
    );
  }

  // '핫한 캐치업' 섹션을 구성하는 위젯
  Widget _buildHotCatchUpsSection() {
    return Container(
      height: 220,
      child: Obx(() {
        var hotCatchUpsList = controller.hotCatchUps.value;
        return _buildHotListView(hotCatchUpsList);
      }),
    );
  }

  // '핫한 캐치업' 리스트뷰 빌더
  Widget _buildHotListView(List<CatchUp> hotCatchUpsList) {
    return Align(
      alignment: Alignment.center,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hotCatchUpsList.length,
        itemBuilder: (context, index) {
          final catchUp = hotCatchUpsList[index];
          // String을 DateTime으로 변환
          final createdAtDate = DateTime.parse(catchUp.createdAt);
          final dateOnly = DateTime(
              createdAtDate.year, createdAtDate.month, createdAtDate.day);
          final formattedDate = DateFormat('yyyy.MM.dd').format(dateOnly);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CardWidget(
              temperature: catchUp.upProfiles.length.toString(),
              avatar: catchUp.author.avatar ?? 'assets/man-a.svg',
              position: catchUp.author.nickname,
              nickname: catchUp.author.nickname,
              url: catchUp.url,
              hashTags: catchUp.category,
              thumbnail: catchUp.thumbnail,
              description: catchUp.title,
              createdTime: formattedDate,
              postId: catchUp.id,
            ),
          );
        },
      ),
    );
  }

  // 주요 캐치업 ListView를 구성하는 Flexible 위젯
  Flexible _buildFlexibleCatchUpsListView() {
    return Flexible(
      flex: 4,
      child: Obx(() {
        var catchUpsList = controller.isSearching.isTrue
            ? controller.searchCatchUps.value
            : controller.catchUps.value;
        return _buildListView(catchUpsList);
      }),
    );
  }

  // 주요 캐치업 리스트뷰 빌더
  // 주요 캐치업 리스트뷰 빌더
  ListView _buildListView(List<CatchUp> catchUpsList) {
    return ListView.builder(
      itemCount: catchUpsList.length,
      itemBuilder: (context, index) {
        final catchUp = catchUpsList[index];
        // String을 DateTime으로 변환
        final createdAtDate = DateTime.parse(catchUp.createdAt);
        final dateOnly = DateTime(
            createdAtDate.year, createdAtDate.month, createdAtDate.day);
        final formattedDate = DateFormat('yyyy.MM.dd').format(dateOnly);

        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: CardWidget(
            temperature: catchUp.upProfiles.length.toString(),
            avatar: catchUp.author.avatar ?? 'assets/man-a.svg',
            position: catchUp.author.position,
            nickname: catchUp.author.nickname,
            url: catchUp.url,
            hashTags: catchUp.category ?? '태그가 없어요 ㅠㅠ',
            thumbnail: catchUp.thumbnail,
            description: catchUp.title,
            createdTime: formattedDate,
            postId: catchUp.id,
          ),
        );
      },
    );
  }

  // 검색 필드 위젯
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
                suffixIcon: IconButton(
                    onPressed: () {
                      controller
                          .startSearch(controller.searchTextcontroller.text);
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
