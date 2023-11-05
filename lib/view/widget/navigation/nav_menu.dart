import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

enum TitleDirection { center, left }

class NavMenu extends StatelessWidget {
  const NavMenu({
    super.key,
    required this.title,
    required this.titleDirection,
    this.withEmoji,
    this.emoji,
    this.withIconButton = true,
    this.onButtonPressed,
    this.color,
  }) : assert(!(withEmoji == true && titleDirection != TitleDirection.left),
            'When withEmoji is true, titleDirection must be TitleDirection.left');

  final String title;
  final TitleDirection titleDirection;
  final bool? withEmoji;
  final String? emoji;
  final bool withIconButton;
  final VoidCallback? onButtonPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Widget textWidget = Text(
      title,
      style: AppTextStyles.body18B(color: color ?? AppColor.black80),
    );
    if (withEmoji == true) {
      textWidget = Row(
        children: [
          Image.asset(
            emoji ?? 'assets/icons/pngs/fire.png',
            width: 20,
          ),
          const SizedBox(width: 8),
          textWidget,
        ],
      );
    }

    Alignment iconAlignment = titleDirection == TitleDirection.center
        ? Alignment.centerLeft
        : Alignment.centerRight;
    Alignment textAlignment = titleDirection == TitleDirection.center
        ? Alignment.center
        : Alignment.centerLeft;

    return Material(
      color: Colors.transparent,
      child: IntrinsicHeight(
        child: Stack(children: [
          if (withIconButton)
            Align(
              alignment: iconAlignment,
              child: IconButton(
                onPressed: onButtonPressed ?? () => Get.back(),
                icon: SvgPicture.asset(
                    titleDirection == TitleDirection.center
                        ? 'assets/icons/svgs/Left.svg'
                        : 'assets/icons/svgs/Right.svg',
                    color: color ?? Colors.black // 색상 지정
                    ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Align(alignment: textAlignment, child: textWidget),
          ),
        ]),
      ),
    );
  }
}
