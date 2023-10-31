import 'badge.dart';

class Author {
  final String id;
  final String? avatar;
  final String nickname;
  final Badge badge;
  final String role;
  final String position;
  final int temperature;

  Author(
      {required this.id,
      this.avatar,
      required this.nickname,
      required this.badge,
      required this.role,
      required this.position,
      required this.temperature});
  factory Author.fromJson(Map<String, dynamic> json) {
    try {
      return Author(
        id: json['id'] as String,
        avatar: json['avatar'] as String?,
        nickname: json['nickname'] as String,
        badge: Badge.fromJson(json['badge'] as Map<String, dynamic>),
        role: json['role'] as String,
        position: json['position'] as String,
        temperature: json['temperature'] as int,
      );
    } catch (e) {
      print("Author 객체 생성 중 오류 발생: $e");
      throw FormatException('Invalid JSON format for Author: $e');
      // 여기에서 기본값을 가진 Author 객체를 반환하거나, 계속 예외를 던질 수 있습니다.
    }
  }
}
