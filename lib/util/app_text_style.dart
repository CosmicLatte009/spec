import 'package:flutter/material.dart';

class AppTextStyles {
  static const bold = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
  );
  static const medium = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
  );
  static const regular = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
  );

  static TextStyle header40({
    Color color = Colors.black,
  }) =>
      bold.copyWith(fontSize: 40, color: color);
  static TextStyle header32({
    Color color = Colors.black,
  }) =>
      bold.copyWith(fontSize: 32, color: color);

  static TextStyle header28({
    Color color = Colors.black,
    Color? backgroundColor,
  }) =>
      bold.copyWith(
          fontSize: 28,
          color: color,
          backgroundColor: backgroundColor ?? Colors.transparent);

  static TextStyle header24({
    Color color = Colors.black,
    Color? backgroundColor,
  }) =>
      bold.copyWith(fontSize: 24, color: color);
  static TextStyle header20({Color color = Colors.black}) =>
      bold.copyWith(fontSize: 20, color: color);

  static TextStyle body20B({Color color = Colors.black}) =>
      bold.copyWith(fontSize: 20, color: color);

  static TextStyle body18B({Color color = Colors.black}) =>
      bold.copyWith(fontSize: 18, color: color);

  static TextStyle body16B({Color color = Colors.black}) =>
      bold.copyWith(fontSize: 16, color: color);

  static TextStyle body14B({Color color = Colors.black}) =>
      bold.copyWith(fontSize: 13, color: color);

  static TextStyle body12B({Color color = Colors.black}) =>
      bold.copyWith(fontSize: 12, color: color);

  static TextStyle body20M({Color color = Colors.black}) =>
      medium.copyWith(fontSize: 20, color: color);

  static TextStyle body18M({Color color = Colors.black}) =>
      medium.copyWith(fontSize: 18, color: color);

  static TextStyle body16M({Color color = Colors.black}) =>
      medium.copyWith(fontSize: 16, color: color);

  static TextStyle body14M({Color color = Colors.black}) =>
      medium.copyWith(fontSize: 14, color: color);

  static TextStyle body12M({Color color = Colors.black}) =>
      medium.copyWith(fontSize: 12, color: color);

  static TextStyle body20R({Color color = Colors.black}) =>
      regular.copyWith(fontSize: 20, color: color);

  static TextStyle body18R({Color color = Colors.black}) =>
      regular.copyWith(fontSize: 18, color: color);

  static TextStyle body16R({Color color = Colors.black}) =>
      regular.copyWith(fontSize: 16, color: color);

  static TextStyle body14R({Color color = Colors.black}) =>
      regular.copyWith(fontSize: 14, color: color);

  static TextStyle body12R({Color color = Colors.black}) =>
      regular.copyWith(fontSize: 12, color: color);
}
