class Profile {
  String id;
  String nickname;
  String bio;
  String? avatar;
  String position;
  String createdAt;
  String updatedAt;
  String? urlGithub;
  String? urlBehance;
  String? urlBlog;
  String? urlWeb;
  String? urlEtc;
  String? urlPortfolio;
  String role;
  String? badgeId;
  String accountId;
  int temperature;

  Profile({
    required this.id,
    required this.nickname,
    required this.bio,
    this.avatar,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    this.urlGithub,
    this.urlBehance,
    this.urlBlog,
    this.urlWeb,
    this.urlEtc,
    this.urlPortfolio,
    required this.role,
    this.badgeId,
    required this.accountId,
    required this.temperature,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      nickname: map['nickname'],
      bio: map['bio'],
      avatar: map['avatar'],
      position: map['position'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      urlGithub: map['urlGithub'],
      urlBehance: map['urlBehance'],
      urlBlog: map['urlBlog'],
      urlWeb: map['urlWeb'],
      urlEtc: map['urlEtc'],
      urlPortfolio: map['urlPortfolio'],
      role: map['role'],
      badgeId: map['badgeId'],
      accountId: map['accountId'],
      temperature: map['temperature'],
    );
  }
}
