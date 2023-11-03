import 'package:spec/model/applied_profile.dart';
import 'package:spec/model/mogak_talk.dart';
import 'package:spec/model/up_profile.dart';

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
  List<MogakTalk?> talks;
  List<UpProfiles?> upProfiles;

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
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      isDeleted: map['isDeleted'] as bool,
      maxMember: map['maxMember'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deletedAt: map['deletedAt'] != null ? map['deletedAt'] as String : null,
      authorId: map['authorId'] as String,
      hashtag: map['hashtag'] != null ? map['hashtag'] as String : null,
      visiblityStatus: map['visiblityStatus'] as String,
      temperature: map['temperature'] as int,
      appliedProfiles: List<AppliedProfile>.from(
        (map['appliedProfiles'] as List).map(
          (x) => AppliedProfile.fromMap(x as Map<String, dynamic>),
        ),
      ),
      talks: List<MogakTalk?>.from(
        (map['talks'] as List).map(
          (x) =>
              x != null ? MogakTalk.fromMap(x as Map<String, dynamic>) : null,
        ),
      ),
      upProfiles: List<UpProfiles?>.from(
        (map['upProfiles'] as List).map(
          (x) =>
              x != null ? UpProfiles.fromMap(x as Map<String, dynamic>) : null,
        ),
      ),
    );
  }
}
