class MyProfile {
  final String id;
  final String? avatar;
  final String nickname;
  final String? badge;
  final String role;
  final String position;
  final int temperature;

  MyProfile({
    required this.id,
    this.avatar,
    required this.nickname,
    this.badge,
    required this.role,
    required this.position,
    required this.temperature,
  });

  // Factory constructor for creating a User instance from a Map (e.g., JSON)
  factory MyProfile.fromMap(Map<String, dynamic> map) {
    return MyProfile(
      id: map['id'],
      avatar: map['avatar'],
      nickname: map['nickname'],
      badge: map['badge'],
      role: map['role'],
      position: map['position'],
      temperature: map['temperature'] ?? 0,
    );
  }
}
