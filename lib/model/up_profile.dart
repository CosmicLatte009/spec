import 'Profile.dart';

class UpProfile {
  final String id;
  final Profile profile;

  UpProfile({
    required this.id,
    required this.profile,
  });

  factory UpProfile.fromJson(Map<String, dynamic> json) => UpProfile(
        id: json['id'],
        profile: Profile.fromJson(json['profile']),
      );
}
