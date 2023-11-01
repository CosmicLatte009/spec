class AppliedProfile {
  String id;
  String? avatar;
  String nickname;
  String role;
  String position;
  int? temperature;

  AppliedProfile({
    required this.id,
    this.avatar,
    required this.nickname,
    required this.role,
    required this.position,
    this.temperature,
  });

  factory AppliedProfile.fromMap(Map<String, dynamic> map) {
    return AppliedProfile(
      id: map['id'],
      avatar: map['avatar'],
      nickname: map['nickname'],
      role: map['role'],
      position: map['position'],
      temperature: map['temperature'],
    );
  }
}
