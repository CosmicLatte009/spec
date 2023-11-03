import 'author.dart';

class MogakTalk {
  String id;
  String authorId;
  String? parentId;
  String content;
  String createdAt;
  String updatedAt;
  bool isDeleted;
  Author author;
  String? catchUpId;
  int temperature;
  String mogakId;
  String? deletedAt;
  MogakTalk({
    required this.id,
    required this.authorId,
    this.parentId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.author,
    this.catchUpId,
    required this.temperature,
    required this.mogakId,
    this.deletedAt,
  });

  factory MogakTalk.fromMap(Map<String, dynamic> map) {
    return MogakTalk(
      id: map['id'] as String,
      authorId: map['authorId'] as String,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
      content: map['content'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      isDeleted: map['isDeleted'] as bool,
      author: Author.fromMap(map['author'] as Map<String, dynamic>),
      catchUpId: map['catchUpId'] != null ? map['catchUpId'] as String : null,
      temperature: map['temperature'] as int,
      mogakId: map['mogakId'] as String,
      deletedAt: map['deletedAt'] != null ? map['deletedAt'] as String : null,
    );
  }
}
