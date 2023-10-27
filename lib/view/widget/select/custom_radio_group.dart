import 'package:flutter/material.dart';
import '../../../util/app_color.dart';
import 'custom_radio.dart';

class CustomRadioGroup<T> extends StatefulWidget {
  final List<T> items;
  final int selectedIndex;
  final Function(int) onItemSelect;
  final Axis direction;
  final double itemSpacing;
  final bool tileColorActive;
  final Color selectedTitleColor;

  const CustomRadioGroup({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelect,
    this.direction = Axis.vertical,
    this.itemSpacing = 0.0,
    this.tileColorActive = false,
    this.selectedTitleColor = AppColor.primary05,
  });

  @override
  State<CustomRadioGroup> createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState<T> extends State<CustomRadioGroup> {
  T get selectedItemValue => widget.items[widget.selectedIndex];

  @override
  Widget build(BuildContext context) {
    List<Widget> customRadios = [];

    for (int i = 0; i < widget.items.length; i++) {
      customRadios.add(
        CustomRadio(
          index: i,
          selectedIndex: widget.selectedIndex,
          text: widget.items[i],
          onSelect: widget.onItemSelect,
          tileColorActive: widget.tileColorActive,
          selectedTitleColor: widget.selectedTitleColor,
        ),
      );
      if (i < widget.items.length - 1) {
        customRadios.add(
          widget.direction == Axis.vertical
              ? SizedBox(height: widget.itemSpacing)
              : SizedBox(width: widget.itemSpacing),
        );
      }
    }

    return Material(
      child: widget.direction == Axis.vertical
          ? Column(children: customRadios)
          : Row(children: customRadios),
    );
  }
}
