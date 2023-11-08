import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../button/custom_button.dart';

enum AvatarSize { w60, w45, w40 }

enum BadgeDirection { column, row }

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.avatarSvg,
    this.avatarSize = AvatarSize.w60,
    this.direction = BadgeDirection.column,
    this.nickName,
    this.shortName,
    this.role,
    this.roleHeight,
    this.nickNameSize,
    this.avatarUrl,
  });

  final String? avatarSvg;
  final String? avatarUrl;
  final AvatarSize avatarSize;
  final BadgeDirection direction;
  final String? nickName;
  final String? shortName;
  final String? role;
  final double? roleHeight;
  final TextStyle? nickNameSize;

  TextStyle getFinalNickNameSize() {
    if (direction == BadgeDirection.row && avatarSize == AvatarSize.w60) {
      return AppTextStyles.body14B();
    }
    if (direction == BadgeDirection.column && avatarSize == AvatarSize.w45) {
      return AppTextStyles.body9B();
    }
    if (direction == BadgeDirection.column && avatarSize == AvatarSize.w40) {
      return AppTextStyles.body9B();
    }

    return AppTextStyles.body12B();
  }

  double getFinalRoleHeightSize() {
    if (direction == BadgeDirection.column &&
        (avatarSize == AvatarSize.w45 || avatarSize == AvatarSize.w40)) {
      return 17;
    }
    return 22;
  }

  @override
  Widget build(BuildContext context) {
    Widget avatarContainer() {
      double finalContainerMinWidth;
      double finalContainerHeight;
      double finalRadius;
      double finalSvgSize;
      double finalShortNamePosition;
      double finalShortNameHeight;

      switch (avatarSize) {
        case AvatarSize.w45:
          finalContainerMinWidth = 79;
          finalContainerHeight = role != null
              ? 77.25
              : shortName != null
                  ? 54.75
                  : 54;
          finalRadius = 22.5;
          finalSvgSize = 37.5;
          finalShortNamePosition = 41.25;
          finalShortNameHeight = 13.5;
          break;

        case AvatarSize.w40:
          if (direction == BadgeDirection.column) {
            finalContainerMinWidth = 79;
          } else {
            finalContainerMinWidth = 0;
          }
          if (direction == BadgeDirection.column) {
            finalContainerHeight = role != null
                ? 77.25
                : shortName != null
                    ? 54.75
                    : 54;
          } else {
            finalContainerHeight = shortName != null ? 48 : 40;
          }
          finalRadius = 20;
          finalSvgSize = 33.3;
          finalShortNamePosition = 36;
          finalShortNameHeight = 12;
          break;

        case AvatarSize.w60:
        default:
          finalContainerMinWidth = 79;
          if (direction == BadgeDirection.column) {
            finalContainerHeight = role != null
                ? 103
                : shortName != null
                    ? 95
                    : 80;
          } else {
            finalContainerHeight = shortName != null ? 73 : 60;
          }
          finalRadius = 30;
          finalSvgSize = 50;
          finalShortNamePosition = 55;
          finalShortNameHeight = 18;
          break;
      }

      return Container(
        constraints: BoxConstraints(minWidth: finalContainerMinWidth),
        height: finalContainerHeight,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: <Widget>[
            CircleAvatar(
              radius: finalRadius,
              backgroundColor: AppColor.primary05,
              child: (avatarUrl != null && avatarUrl != "")
                  ? Image.network(
                      avatarUrl!,
                      width: finalSvgSize,
                      height: finalSvgSize,
                    )
                  : SvgPicture.asset(
                      'assets/icons/svgs/man-a.svg',
                      width: finalSvgSize,
                      height: finalSvgSize,
                    ),
            ),
            if (shortName != null)
              Positioned(
                top: finalShortNamePosition,
                child: CustomButton(
                  text: shortName ?? 'shortName',
                  height: finalShortNameHeight,
                ),
              ),
            if (direction == BadgeDirection.column)
              ..._getAdditionalColumnWidgets(),
          ],
        ),
      );
    }

    switch (direction) {
      case BadgeDirection.column:
        return Column(
          children: [
            avatarContainer(),
          ],
        );
      case BadgeDirection.row:
        return Row(
          children: [
            avatarContainer(),
            const SizedBox(width: 12.24),
            ..._getAdditionalRowWidgets(),
          ],
        );
    }
  }

  List<Widget> _getAdditionalColumnWidgets() {
    List<Widget> widgets = [];

    if (role != null) {
      widgets.add(
        Positioned(
          bottom: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                nickName ?? 'nickName',
                style: nickNameSize ?? getFinalNickNameSize(),
              ),
              const SizedBox(width: 8),
              CustomButton(
                  text: role != null
                      ? role == "NEWBIE"
                          ? '수료생'
                          : (role == 'Admin' ? '관리자' : '멘토')
                      : 'role',
                  height: roleHeight ?? getFinalRoleHeightSize(),
                  type: ButtonType.neutral),
            ],
          ),
        ),
      );
    } else if (nickName != null) {
      widgets.add(
        Positioned(
          bottom: 0,
          child: Text(
            nickName ?? 'nickName',
            style: nickNameSize ?? getFinalNickNameSize(),
          ),
        ),
      );
    }
    return widgets;
  }

  List<Widget> _getAdditionalRowWidgets() {
    List<Widget> widgets = [];

    if (role != null) {
      widgets.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              nickName ?? 'nickName',
              style: nickNameSize ?? getFinalNickNameSize(),
            ),
            const SizedBox(width: 8),
            CustomButton(
                text: role != null
                    ? role == "NEWBIE"
                        ? '수료생'
                        : (role == 'Admin' ? '관리자' : '멘토')
                    : 'role',
                height: roleHeight ?? getFinalRoleHeightSize(),
                type: ButtonType.neutral),
          ],
        ),
      );
    } else if (nickName != null) {
      widgets.add(
        Text(
          nickName ?? 'nickName',
          style: nickNameSize ?? getFinalNickNameSize(),
        ),
      );
    }
    return widgets;
  }
}
