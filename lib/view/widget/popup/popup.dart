import 'package:flutter/material.dart';
import 'package:spec/util/app_text_style.dart';

class Popup extends StatelessWidget {
  const Popup({
    Key? key,
    required this.child,
    this.isWide = false,
    this.shadow,
    this.label,
  }) : super(key: key);

  final Widget child;
  final bool isWide;
  final bool? shadow;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: isWide ? 370.0 : 242,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 17,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: shadow == true
              ? [
                  const BoxShadow(
                    color: Color(0x40000000),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label!,
                    style: AppTextStyles.body18B(),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            child,
          ],
        ),
      ),
    );
  }
}
