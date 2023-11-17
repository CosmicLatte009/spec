import 'dart:convert';

import 'package:spec/model/me/my_res.dart';

class MyInfo {
  int? year;
  List<MyRes> res;

  MyInfo({
    required this.year,
    required this.res,
  });

  factory MyInfo.fromJson(String str) => MyInfo.fromMap(json.decode(str));

  factory MyInfo.fromMap(Map<String, dynamic> json) {
    return MyInfo(
      year: json['year'] as int? ?? 2001, // 'year'가 null일 경우 기본값으로 2001을 사용합니다.
      res: json['res'] != null // 'res'가 null이 아닐 때만 실행합니다.
          ? List<MyRes>.from(
              (json['res'] as List<dynamic>).map(
                (x) => MyRes.fromMap(
                    x as Map<String, dynamic>), // 'x'를 MyRes 객체로 변환합니다.
              ),
            )
          : [], // 'res'가 null일 경우 빈 리스트를 제공합니다.
    );
  }
}
