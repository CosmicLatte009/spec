import 'package:flutter/material.dart';
import 'package:spec/util/avatar_color.dart';

List<Color> get colorList => [
      AvatarColor.color1,
      AvatarColor.color2,
      AvatarColor.color3,
      AvatarColor.color4,
      AvatarColor.color5,
      AvatarColor.color6,
      AvatarColor.color7,
      AvatarColor.color8,
    ];

class Palette extends StatelessWidget {
  const Palette({
    super.key,
    this.colorPicker,
  });
  final colorPicker;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colorList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: GestureDetector(
                onTap: () {
                  colorPicker(colorList[index]);
                },
                child: Container(
                  width: 28,
                  height: 28,
                  color: colorList[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
