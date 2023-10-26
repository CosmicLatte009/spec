import 'package:flutter/material.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

class CustomRadio extends StatefulWidget {
  const CustomRadio({
    required this.index,
    required this.selectedIndex,
    required this.onSelect,
    required this.text,
    this.tileColorActive = false,
    this.selectedTitleColor = AppColor.primary05,
    this.paddingLeft = 16.0,
    this.paddingTop = 8.0,
    this.paddingRight = 0.0,
    this.paddingBottom = 8.0,
  });

  final int index;
  final int selectedIndex;
  final String text;
  final Function(int) onSelect;
  final bool tileColorActive;
  final Color selectedTitleColor;
  final double paddingLeft;
  final double paddingTop;
  final double paddingRight;
  final double paddingBottom;

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.index == widget.selectedIndex;
    return GestureDetector(
      onTap: () {
        widget.onSelect(widget.index);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(widget.paddingLeft, widget.paddingTop,
            widget.paddingRight, widget.paddingBottom),
        color: isSelected && widget.tileColorActive
            ? widget.selectedTitleColor
            : Colors.transparent,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                widget.onSelect(widget.index);
              },
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 17.0,
                  height: 17.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.primary30,
                      width: 1.0,
                    ),
                  ),
                  child: isSelected
                      ? Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            width: 11.0,
                            height: 11.0,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.primary60),
                          ))
                      : null,
                ),
              ),
            ),
            SizedBox(width: 16),
            Text(
              widget.text,
              style: isSelected
                  ? AppTextStyles.body14M(color: AppColor.primary80)
                  : AppTextStyles.body14R(color: AppColor.black80),
            ),
          ],
        ),
      ),
    );
  }
}
