// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'author.dart';

class Talk {
  String id;
  String authorId;
  String? parentId;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  bool isDeleted;
  Author author;
  int? childrenLength;
  List<Author>? upProfiles;
  int temperature;
  List<Talk>? children;
  Talk({
    required this.id,
    required this.authorId,
    this.parentId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.author,
    this.childrenLength,
    this.upProfiles,
    required this.temperature,
    this.children,
  });

  factory Talk.fromMap(Map<String, dynamic> map) {
    return Talk(
      id: map['id'] ?? '',
      authorId: map['authorId'],
      parentId: map['parentId'],
      content: map['content'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      isDeleted: map['deletedAt'] !=
          null, // JSON에는 deletedAt이 존재하므로 이를 바탕으로 isDeleted 상태를 결정합니다.
      author: Author.fromMap(map['author'] as Map<String, dynamic>),
      childrenLength: map['childrenLength'] ?? 0,
      upProfiles: map['upProfiles'] != null
          ? List<Author>.from(
              (map['upProfiles'] as List).map(
                (x) => Author.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      temperature: map['temperature'] ?? 0,
      children: map['children'] != null
          ? List<Talk>.from((map['children'] as List)
              .map((x) => Talk.fromMap(x as Map<String, dynamic>)))
          : null,
    );
  }

  @override
  String toString() {
    return 'Talk(id: $id, authorId: $authorId, parentId: $parentId, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, author: $author, childrenLength: $childrenLength, upProfiles: $upProfiles, temperature: $temperature, children: $children)';
  }
}
