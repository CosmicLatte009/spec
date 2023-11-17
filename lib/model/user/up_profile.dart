import 'profile.dart';

class UpProfiles {
  final String id;
  final Profile profile;

  UpProfiles({
    required this.id,
    required this.profile,
  });

  factory UpProfiles.fromMap(Map<String, dynamic> map) => UpProfiles(
        id: map['id'],
        profile: Profile.fromMap(map['profile']),
      );
}
