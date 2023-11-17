class Badge {
  String shortName;
  String bgColor;
  String fgColor;

  Badge({
    required this.shortName,
    required this.bgColor,
    required this.fgColor,
  });

  factory Badge.fromMap(Map<String, dynamic> map) {
    return Badge(
      shortName: map['shortName'],
      bgColor: map['bgColor'],
      fgColor: map['fgColor'],
    );
  }
}
