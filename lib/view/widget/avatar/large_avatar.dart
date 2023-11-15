import 'package:flutter/material.dart';

class LargeAvatar extends StatelessWidget {
  const LargeAvatar({super.key, required this.avatarUrl});
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      avatarUrl,
      width: 200,
    );
  }
}
