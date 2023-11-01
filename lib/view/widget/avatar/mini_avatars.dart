import 'package:flutter/material.dart';

class MiniAvatars extends StatelessWidget {
  const MiniAvatars({
    super.key,
    required this.number,
    required this.child,
  });
  final int number;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = [];

    int count = (number > 3) ? 3 : number;

    for (var i = 0; i < count; i++) {
      icons.add(
        child,
      );
    }

    return Row(
      children: icons,
    );

    // @todo not work
    // return SizedBox(
    //   width: 60,
    //   child: Stack(
    //     clipBehavior: Clip.none,
    //     children: List.generate(count, (index) {
    //       return Positioned(
    //         left: 8.0 * index,
    //         child: child,
    //       );
    //     }),
    //   ),
    // );
  }
}
