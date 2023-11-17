import 'package:flutter/material.dart';
import 'package:spec/model/user/applied_profile.dart';
import 'package:spec/view/widget/avatar/user_avatar.dart';

class JoinAvatars extends StatelessWidget {
  const JoinAvatars({super.key, required this.appliedProfiles});
  final List<AppliedProfile> appliedProfiles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, idx) {
        return UserAvatar(
          avatarUrl: appliedProfiles[idx].avatar,
          direction: BadgeDirection.column,
          shortName: appliedProfiles[idx].badge != null
              ? appliedProfiles[idx].badge!.shortName
              : null,
          nickName: appliedProfiles[idx].nickname,
        );
      },
      separatorBuilder: (context, idx) {
        return const SizedBox(width: 10);
      },
      itemCount: appliedProfiles.length,
    );
  }
}
