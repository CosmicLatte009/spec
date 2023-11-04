class MeUp {
  String id;
  String profileId;
  String itemId;
  String itemType;
  String createdAt;
  MeUp({
    required this.id,
    required this.profileId,
    required this.itemId,
    required this.itemType,
    required this.createdAt,
  });

  factory MeUp.fromMap(Map<String, dynamic> map) {
    return MeUp(
      id: map['id'] as String,
      profileId: map['profileId'] as String,
      itemId: map['itemId'] as String,
      itemType: map['itemType'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}
