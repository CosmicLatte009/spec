import 'package:flutter/material.dart';

class FullListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 예시로 단순한 ListView를 사용합니다. 실제로는 프로젝트 요구에 맞게 구성해야 합니다.
    return Scaffold(
      appBar: AppBar(
        title: Text('전체 리스트'),
      ),
      body: ListView.builder(
        itemCount: 100, // 예시 데이터 개수
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('항목 $index'),
          );
        },
      ),
    );
  }
}
