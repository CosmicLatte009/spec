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
  final Author author;
  final List<UpProfile> upProfiles;

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

  factory CatchUp.fromJson(Map<String, dynamic> json) => CatchUp(
        id: json['id'] ?? 'default',
        title: json['title'] ?? 'default',
        slug: json['slug'] ?? 'default',
        content: json['content'] ?? 'default',
        url: json['url'] ?? 'default',
        thumbnail: json['thumbnail'] ?? 'default',
        authorId: json['authorId'] ?? 'default',
        temperature: json['temperature'] ?? 'default',
        status: json['status'] ?? 'default',
        createdAt: json['createdAt'] ?? 'default',
        updatedAt: json['updatedAt'] ?? 'default',
        category: json['category'] ?? 'default',
        hashtag: json['hashtag'] ?? 'default',
        author: Author.fromMap(json['author']),
        upProfiles: List<UpProfile>.from(
            json['upProfiles'].map((x) => UpProfile.fromJson(x))),
      );
}
