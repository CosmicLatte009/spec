class Badge {
  final String shortName;
  final String fgColor;
  final String bgColor;

  Badge({
    required this.shortName,
    required this.fgColor,
    required this.bgColor,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
        shortName: json['shortName'],
        fgColor: json['fgColor'],
        bgColor: json['bgColor'],
      );
}
