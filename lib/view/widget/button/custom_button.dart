import 'package:flutter/material.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

enum ButtonType {
  main,
  outline,
  neutral,
}

enum ButtonSize {
  xLarge,
  medium,
  small,
  xSmall,
}

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.text,
    this.width,
    this.height,
    this.size,
    this.type = ButtonType.main,
    this.onTap,
    this.disabled = false,
  })  : assert(size == null || (width == null && height == null),
            'If size is specified, width and height should not be provided.'),
        assert(disabled != true || onTap == null,
            'onTap must not be provided if the button is disabled.'),
        super(key: key);

  final String text;
  final double? width;
  final double? height;
  final ButtonSize? size;
  final ButtonType type;
  final Function()? onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    double? finalWidth;
    double? finalHeight;
    double finalPadding = 8.0;
    double finalBorderRadius = 6.0;
    TextStyle? finalTextSize;
    Color finalColor;

    if (disabled) {
      finalColor = AppColor.black20;
    } else if (type == ButtonType.outline) {
      finalColor = AppColor.primary60;
    } else if (type == ButtonType.neutral) {
      finalColor = AppColor.black60;
    } else {
      finalColor = AppColor.white;
    }

    if (width != null || height != null) {
      finalWidth = width; // 여기서 width가 null이면 0.0으로 설정하게 됩니다.
      finalHeight = height; // 여기서 height가 null이면 0.0으로 설정하게 됩니다.
      finalPadding = 8;
      if (height! >= 56) {
        finalTextSize = AppTextStyles.body18M(color: finalColor);
      }
      if (height! >= 40 && height! < 56) {
        finalTextSize = AppTextStyles.body16R(color: finalColor);
      }

      if (height! >= 32 && height! < 40) {
        finalTextSize = AppTextStyles.body14R(color: finalColor);
      }

      if (height! >= 24 && height! < 32) {
        finalTextSize = AppTextStyles.body12R(color: finalColor);
      }

      if (height! <= 22) {
        finalTextSize = AppTextStyles.body12R(color: finalColor);
      }
      if (height! <= 18) {
        finalTextSize = AppTextStyles.body12R(color: finalColor);
        finalPadding = 6.5;
        finalBorderRadius = 6.0;
      }
      if (height! <= 14) {
        finalTextSize = AppTextStyles.body9R(color: finalColor);
        finalPadding = 4.88;
        finalBorderRadius = 4.5;
      }
      if (height! <= 12) {
        finalTextSize = AppTextStyles.body8R(color: finalColor);
        finalPadding = 4.5;
        finalBorderRadius = 2.63;
      }
    } else if (size != null) {
      switch (size) {
        case ButtonSize.xSmall:
          finalWidth = 85.0;
          finalHeight = 24.0;
          finalTextSize = AppTextStyles.body12R(color: finalColor);
          break;
        case ButtonSize.small:
          finalWidth = 165.0;
          finalHeight = 32.0;
          finalTextSize = AppTextStyles.body14R(color: finalColor);
          break;
        case ButtonSize.medium:
          finalWidth = 165.0;
          finalHeight = 40.0;
          finalTextSize = AppTextStyles.body16R(color: finalColor);
          break;
        case ButtonSize.xLarge:
          finalWidth = 370.0;
          finalHeight = 56.0;
          finalBorderRadius = 10.0;
          finalTextSize = AppTextStyles.body18M(color: finalColor);
          break;
        default:
          finalWidth = 0.0; // 기본값
          finalHeight = 0.0; // 기본값
          finalPadding = 8.0;
      }
    } else {
      // 만약 size도 null이고 width, height 둘 다 null이라면 기본값으로 설정합니다.
      finalWidth = double.infinity;
      finalHeight = 56.0;
    }
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        padding: width == null
            ? EdgeInsets.symmetric(horizontal: finalPadding)
            : null,
        width: finalWidth,
        height: finalHeight,
        decoration: BoxDecoration(
          color: type == ButtonType.neutral || disabled
              ? AppColor.black05
              : type == ButtonType.outline
                  ? AppColor.primary05
                  : AppColor.primary80,
          borderRadius: BorderRadius.circular(finalBorderRadius),
          border: type == ButtonType.outline && !disabled
              ? Border.all(color: AppColor.strokeBlue, width: 1)
              : null,
        ),
        child: Text(
          text,
          style: finalTextSize,
        ),
      ),
    );
  }
}
