import 'package:spec/model/user/badge.dart';

class AppliedProfile {
  String id;
  String? avatar;
  String nickname;
  Badge? badge;
  String role;
  String position;
  int temperature;

  AppliedProfile({
    required this.id,
    this.avatar,
    required this.nickname,
    this.badge,
    required this.role,
    required this.position,
    required this.temperature,
  });

  factory AppliedProfile.fromMap(Map<String, dynamic> map) {
    return AppliedProfile(
      id: map['id'],
      avatar: map['avatar'],
      nickname: map['nickname'],
      role: map['role'],
      position: map['position'],
      temperature: map['temperature'] ?? 0,
      badge: map['badge'] != null ? Badge.fromMap(map['badge']) : null,
    );
  }
}
