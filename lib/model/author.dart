import 'package:spec/model/badge.dart';

class Author {
  String id;
  String? avatar;
  String nickname;
  Badge? badge;
  String role;
  String position;
  int temperature;

  Author({
    required this.id,
    required this.avatar,
    required this.nickname,
    this.badge,
    required this.role,
    required this.position,
    required this.temperature,
  });

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      id: map['id'],
      avatar: map['avatar'],
      nickname: map['nickname'],
      badge: map['badge'] != null ? Badge.fromMap(map['badge']) : null,
      role: map['role'],
      position: map['position'],
      temperature: map['temperature'] != null ? map['temperature'] as int : 0,
      // Assuming temperature should default to 0 if not provided
    );
  }
}
