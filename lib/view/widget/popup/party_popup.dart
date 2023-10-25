import 'package:flutter/material.dart';
import 'package:spec/view/widget/popup/popup.dart';

class PartyPopup extends StatelessWidget {
  const PartyPopup({
    super.key,
    required this.partyList,
  });
  final List<Map<String, String>> partyList;

  @override
  Widget build(BuildContext context) {
    return Popup(
      label: '참여자 목록',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 24,
          ),
          ListView.separated(
            itemCount: partyList.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemBuilder: (context, index) {
              return const CircleAvatar(); //아바타로 수정하기
            },
          ),
        ],
      ),
    );
  }
}
