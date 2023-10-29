import 'package:spec/model/applied_profile.dart';
import 'package:spec/model/author.dart';

class Mogak {
  String id;
  String title;
  String content;
  bool? isShow;
  bool isDeleted;
  int maxMember;
  String createdAt;
  String updatedAt;
  String? deletedAt;
  String authorId;
  String? hashtag;
  int temperature;
  Author author;
  List<AppliedProfile> appliedProfiles;
  int? up;

  Mogak({
    required this.id,
    required this.title,
    required this.content,
    this.isShow,
    required this.isDeleted,
    required this.maxMember,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.authorId,
    this.hashtag,
    required this.temperature,
    required this.author,
    required this.appliedProfiles,
    this.up,
  });

  factory Mogak.fromMap(Map<String, dynamic> map) {
    return Mogak(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      isShow: map['isShow'],
      isDeleted: map['isDeleted'],
      maxMember: map['maxMember'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      authorId: map['authorId'],
      hashtag: map['hashtag'],
      temperature: map['temperature'],
      author: Author.fromMap(map['author']),
      appliedProfiles: List<AppliedProfile>.from(
          map['appliedProfiles'].map((x) => AppliedProfile.fromMap(x))),
      up: map['up'],
    );
  }
}
