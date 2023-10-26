import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../util/app_color.dart';

class CustomToggle extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;

  CustomToggle({
    required this.value,
    required this.onChanged,
  });

  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 51.0,
      height: 26.0,
      toggleSize: 20.0,
      value: _value,
      borderRadius: 24.0,
      padding: 4.0,
      activeToggleColor: AppColor.primary80,
      inactiveToggleColor: Color(0xFFC5C5C5),
      activeColor: AppColor.primary10,
      inactiveColor: Color(0xFFF2F2F2),
      onToggle: (val) {
        setState(() {
          _value = val;
        });

        widget.onChanged(val);
      },
    );
  }
}
