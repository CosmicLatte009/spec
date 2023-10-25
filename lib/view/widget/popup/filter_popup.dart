import 'package:flutter/material.dart';
import 'package:spec/view/widget/button/button_xsmall.dart';
import 'package:spec/view/widget/popup/filter_items.dart';
import 'package:spec/view/widget/popup/popup.dart';

class FilterPopup extends StatefulWidget {
  const FilterPopup({super.key});

  @override
  State<FilterPopup> createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  List<Map<String, String>> selected = [];
  List<String> dateFilter = ['전체', '오름차순', '내림차순'];
  List<String> nameFilter = ['전체', '오름차순', '내림차순'];
  List<String> like = ['많은 순', '적은 순'];

  @override
  Widget build(BuildContext context) {
    return Popup(
      label: '필터',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 33,
          ),
          FilterItems(label: '날짜', list: dateFilter),
          FilterItems(label: '이름', list: nameFilter),
          FilterItems(label: '좋아요', list: like),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonXsmall(
                controller: () {},
                text: '초기화',
                width: 100,
                outline: true,
              ),
              const SizedBox(
                width: 10,
              ),
              ButtonXsmall(
                controller: () {},
                text: '확인',
                width: 100,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
