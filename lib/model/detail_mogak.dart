import 'package:spec/model/applied_profile.dart';
import 'package:spec/model/profile.dart';

class DetailMogak {
  String id;
  String title;
  String content;
  bool isDeleted;
  int maxMember;
  String createdAt;
  String updatedAt;
  String? deletedAt;
  String authorId;
  String? hashtag;
  String visiblityStatus;
  int temperature;
  List<AppliedProfile> appliedProfiles;
  List<dynamic> talks; //@todo 추후 talk 수정
  List<Profile?> upProfiles;

  DetailMogak({
    required this.id,
    required this.title,
    required this.content,
    required this.isDeleted,
    required this.maxMember,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.authorId,
    this.hashtag,
    required this.visiblityStatus,
    required this.temperature,
    required this.appliedProfiles,
    required this.talks,
    required this.upProfiles,
  });

  factory DetailMogak.fromMap(Map<String, dynamic> map) {
    return DetailMogak(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      isDeleted: map['isDeleted'],
      maxMember: map['maxMember'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      authorId: map['authorId'],
      hashtag: map['hashtag'],
      visiblityStatus: map['visiblityStatus'],
      temperature: map['temperature'],
      appliedProfiles: List<AppliedProfile>.from(
          map['appliedProfiles'].map((x) => AppliedProfile.fromMap(x))),
      talks: List<dynamic>.from(map['talks'] ?? []),
      upProfiles: List<Profile>.from(
          map['upProfiles'].map((x) => AppliedProfile.fromMap(x))),
    );
  }
}
