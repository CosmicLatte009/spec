// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'author.dart';
import 'talk.dart';

class DetailTalk {
  String id;
  String authorId;
  String? parentId;
  String content;
  String createdAt;
  String updatedAt;
  bool isDeleted;
  Author author;
  int childrenLength;
  List<Author>? upProfiles;
  int temperature;
  List<Talk>? children;
  DetailTalk({
    required this.id,
    required this.authorId,
    this.parentId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.author,
    required this.childrenLength,
    this.upProfiles,
    required this.temperature,
    this.children,
  });

  factory DetailTalk.fromMap(Map<String, dynamic> map) {
    return DetailTalk(
      id: map['id'],
      authorId: map['authorId'],
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
      content: map['content'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      isDeleted: map['deletedAt'] !=
          null, // JSON에는 deletedAt이 존재하므로 이를 바탕으로 isDeleted 상태를 결정합니다.
      author: Author.fromMap(map['author'] as Map<String, dynamic>),
      childrenLength: map['childrenLength'],
      upProfiles: map['upProfiles'] != null
          ? List<Author>.from(
              (map['upProfiles'] as List<int>).map<Author?>(
                (x) => Author.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      temperature: map['temperature'],
      children: map['children'] != null
          ? List<Talk>.from(
              (map['children'] as List<int>).map<Talk?>(
                (x) => Talk.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}
