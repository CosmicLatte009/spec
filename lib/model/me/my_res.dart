class MyRes {
  String id;
  int year;
  int month;
  int rank;
  String profileId;
  int temperature;

  MyRes({
    required this.id,
    required this.year,
    required this.month,
    required this.rank,
    required this.profileId,
    required this.temperature,
  });

  factory MyRes.fromMap(Map<String, dynamic> json) {
    return MyRes(
      // 각 필드에 대해 적절한 기본값 또는 변환을 제공합니다.
      // 예를 들어:
      id: json['id'] as String,
      year: json['year'] as int,
      month: json['month'] as int,
      rank: json['rank'] as int,
      profileId: json['profileId'] as String,
      temperature: json['temperature'] as int,
    );
  }
}
