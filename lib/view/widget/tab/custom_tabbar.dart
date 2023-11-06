import 'package:flutter/material.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/card/avatar_card.dart';

getTabType(String tabItem) {
  switch (tabItem) {
    case '헤어':
      return AvatarAssetType.hair;
    case '피부':
      return AvatarAssetType.face;
    case '표정':
      return AvatarAssetType.emotion;
    case '아이템':
      return AvatarAssetType.item;
    default:
      return null;
  }
}

class CustomTabbar extends StatelessWidget {
  const CustomTabbar({
    super.key,
    required this.tabList,
    required this.tabBarViewList,
  });
  final List<String> tabList;
  final List<Widget> tabBarViewList;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: DefaultTabController(
        length: tabList.length,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 30,
                child: Stack(
                  children: [
                    Positioned.fill(
                      //탭바 bottom에 border 추가하는법: Stack + Positioned.fill
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColor.black20,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TabBar(
                      labelColor: AppColor.primary,
                      unselectedLabelColor: AppColor.black20,
                      labelStyle: AppTextStyles.body14M(),
                      tabs: tabList
                          .map(
                            (tabItem) => Tab(
                              text: tabItem,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  color: AppColor.black05,
                  child: TabBarView(
                    children: tabBarViewList
                        .map(
                          (tabBarView) => tabBarView,
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
