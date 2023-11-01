import 'badge.dart';

class Profile {
  final String id;
  final String? avatar;
  final String nickname;
  final Badge badge;
  final String role;
  final String position;
  final int temperature;

  Profile({
    required this.id,
    this.avatar,
    required this.nickname,
    required this.badge,
    required this.role,
    required this.position,
    required this.temperature,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json['id'],
        avatar: json['avatar'],
        nickname: json['nickname'],
        badge: Badge.fromMap(json['badge']),
        role: json['role'],
        position: json['position'],
        temperature: json['temperature'],
      );
}
