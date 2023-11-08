import 'package:spec/model/applied_profile.dart';
import 'package:spec/model/author.dart';
import 'package:spec/model/up_profile.dart';

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
  String visiblityStatus;
  int temperature;
  Author author;
  List<AppliedProfile> appliedProfiles;
  List<UpProfiles?> upProfiles;
  int? up;
  int? childrenLength;

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
    required this.visiblityStatus,
    required this.temperature,
    required this.author,
    required this.appliedProfiles,
    required this.upProfiles,
    this.up,
    this.childrenLength,
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
      visiblityStatus: map['visiblityStatus'] as String,
      temperature: map['temperature'],
      author: Author.fromMap(map['author']),
      appliedProfiles: List<AppliedProfile>.from(
          map['appliedProfiles'].map((x) => AppliedProfile.fromMap(x))),
      upProfiles: List<UpProfiles>.from(
          map['upProfiles'].map((x) => UpProfiles.fromMap(x))),
      up: map['up'],
      childrenLength: map['childrenLength'] ?? 0,
    );
  }
}
