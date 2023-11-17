class Course {
  final String id;
  final String title;
  final String thumbnail;
  final String slug;
  final String category;
  final String visiblityStatus;
  final DateTime periodStart;
  final DateTime? periodEnd;
  final DateTime? applyExpiredAt;

  Course({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.slug,
    required this.category,
    required this.visiblityStatus,
    required this.periodStart,
    this.periodEnd,
    this.applyExpiredAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      slug: json['slug'],
      category: json['category'],
      visiblityStatus: json['visiblityStatus'],
      periodStart: DateTime.parse(json['periodStart']),
      periodEnd:
          json['periodEnd'] != null ? DateTime.parse(json['periodEnd']) : null,
      applyExpiredAt: json['applyExpiredAt'] != null
          ? DateTime.parse(json['applyExpiredAt'])
          : null,
    );
  }
}

