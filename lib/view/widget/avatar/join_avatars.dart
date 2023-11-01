import 'package:flutter/material.dart';
import 'package:spec/model/applied_profile.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/view/widget/avatar/user_avatar.dart';
import 'package:spec/view/widget/button/custom_button.dart';

class JoinAvatars extends StatelessWidget {
  const JoinAvatars({super.key, required this.appliedProfiles});
  final List<AppliedProfile> appliedProfiles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, idx) {
        return appliedProfiles[idx].avatar != null
            ? UserAvatar(
                avatarUrl: appliedProfiles[idx].avatar,
                direction: BadgeDirection.column,
                shortName: appliedProfiles[idx].badge != null
                    ? appliedProfiles[idx].badge!.shortName
                    : '개발자/1기',
                nickName: appliedProfiles[idx].nickname,
              )
            : UserAvatar(
                avatarSvg: 'assets/icons/svgs/man-a.svg',
                direction: BadgeDirection.column,
                shortName: appliedProfiles[idx].badge != null
                    ? appliedProfiles[idx].badge!.shortName
                    : '개발자/1기',
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
