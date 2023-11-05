import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DefaultAvatar extends StatelessWidget {
  const DefaultAvatar({
    super.key,
    this.width,
    this.hair,
    this.face,
    this.emotion,
    this.item,
  });
  final double? width;
  final String? hair;
  final String? face;
  final String? emotion;
  final String? item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          'assets/avatar/Face/on_face_1.svg',
        ),
        Positioned(
          child: SvgPicture.asset(
            'assets/avatar/Emotion/off_emotion_1.svg',
          ),
        ),
        Positioned(
          child: SvgPicture.asset(
            'assets/avatar/Hair/off_hair_1.svg',
          ),
        ),
      ],
    );
  }
}
