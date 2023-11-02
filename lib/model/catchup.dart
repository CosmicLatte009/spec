import 'package:spec/model/up_profile.dart';

import 'Author.dart';

class CatchUp {
  final String id;
  final String title;
  final String slug;
  final String content;
  final String url;
  final String thumbnail;
  final String authorId;
  final int temperature;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String category;
  final String hashtag;
  Author? author;
  final List<UpProfiles> upProfiles;

  CatchUp({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    required this.url,
    required this.thumbnail,
    required this.authorId,
    required this.temperature,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.hashtag,
    required this.author,
    required this.upProfiles,
  });
  factory CatchUp.fromMap(Map<String, dynamic> map) => CatchUp(
        id: map['id'] as String? ?? 'default',
        title: map['title'] as String? ?? 'default',
        slug: map['slug'] as String? ?? 'default',
        content: map['content'] as String? ?? 'default',
        url: map['url'] as String? ?? 'default',
        thumbnail: map['thumbnail'] as String? ?? 'default',
        authorId: map['authorId'] as String? ?? 'default',
        temperature: map['temperature'] as int? ?? 0, // default value as 0
        status: map['status'] as String? ?? 'default',
        createdAt: map['createdAt'] as String? ?? 'default',
        updatedAt: map['updatedAt'] as String? ?? 'default',
        category: map['category'] as String? ?? 'default',
        hashtag: map['hashtag'] as String? ?? 'default',
        author: map['author'] != null
            ? Author.fromMap(map['author'])
            : null, // assuming Author can be null
        upProfiles: map['upProfiles'] != null
            ? List<UpProfiles>.from(
                map['upProfiles'].map((x) => UpProfiles.fromMap(x)))
            : <UpProfiles>[],
      );
}
