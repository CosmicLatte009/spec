class Badge {
  String shorName;
  String bgColor;
  String fgColor;

  Badge({
    required this.shorName,
    required this.bgColor,
    required this.fgColor,
  });

  factory Badge.fromMap(Map<String, dynamic> map) {
    return Badge(
      shorName: map['shorName'],
      bgColor: map['bgColor'],
      fgColor: map['fgColor'],
    );
  }
}
