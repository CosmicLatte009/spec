import 'package:flutter/material.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';

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
    return Scaffold(
      body: DefaultTabController(
        length: tabList.length,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              Expanded(
                child: TabBarView(
                  children: tabBarViewList
                      .map(
                        (tabBarView) => tabBarView,
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
