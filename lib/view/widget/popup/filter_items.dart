import 'package:flutter/material.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/button/button_xsmall.dart';

class FilterItems extends StatelessWidget {
  const FilterItems({
    super.key,
    required this.list,
    required this.label,
  });
  final List<String> list;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body14M(),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: list
              .map((item) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ButtonXsmall(
                      text: item,
                      width: 57,
                      onTap: () {},
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
