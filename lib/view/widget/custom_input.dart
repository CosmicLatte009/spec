import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';

enum InputType { comment, search, password, basic }

class CustomInput extends StatefulWidget {
  const CustomInput({
    super.key,
    this.controller,
    this.validator,
    this.isSubmitted,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.type = InputType.basic,
    this.isRequired = false,
    this.onSubmit,
  });
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? isSubmitted; // submit시에 true를 함께 보내야 함.
  final String? hint;
  final String? prefixIcon;
  final String? suffixIcon;
  final String? label;
  final InputType? type;
  final bool? isRequired;
  final void Function(String)? onSubmit;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  final FocusNode _focusNode = FocusNode();
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      isActive = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  String? get hintText {
    switch (widget.type) {
      case InputType.comment:
        return '댓글을 작성해주세요.';
      case InputType.search:
        return '내용 검색하기';
      case InputType.password:
        return '이메일 주소를 입력해주세요.';
      default:
        return null;
    }
  }

  Color get hintTextColor {
    switch (widget.type) {
      case InputType.search:
        return AppColor.black20;
      default:
        return AppColor.black30;
    }
  }

  Color? get getValidateColor {
    if (widget.validator != null && widget.controller != null) {
      if (widget.validator!(widget.controller!.text) != null &&
          widget.isSubmitted == true) {
        return AppColor.warning;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      widget.label!,
                      style: AppTextStyles.body14M(),
                    ),
                    if (widget.isRequired == true)
                      Text(
                        '*',
                        style: AppTextStyles.body14M(color: AppColor.warning),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          Stack(
            children: [
              Theme(
                data: ThemeData().copyWith(
                  scaffoldBackgroundColor: Colors.white,
                  colorScheme: ThemeData()
                      .colorScheme
                      .copyWith(primary: AppColor.primary80),
                ),
                child: TextFormField(
                  onFieldSubmitted: widget.onSubmit,
                  obscureText: widget.type == InputType.password,
                  obscuringCharacter: '*',
                  focusNode: _focusNode,
                  validator: widget.validator,
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: widget.hint ?? hintText,
                    hintStyle: AppTextStyles.body14R(
                      color: getValidateColor ?? hintTextColor,
                    ),
                    filled: true,
                    fillColor: widget.type == InputType.search
                        ? AppColor.white
                        : Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.type == InputType.search
                            ? AppColor.black10
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.type == InputType.search
                            ? AppColor.primary40
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle: AppTextStyles.body12R(
                      color: AppColor.warning,
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.warning,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.warning,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    prefixIcon: widget.type == InputType.search
                        ? SvgPicture.asset(
                            'assets/icons/svgs/search.svg',
                            width: 20,
                            height: 20,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                                isActive == true
                                    ? AppColor.primary80
                                    : AppColor.black10,
                                BlendMode.srcIn),
                          )
                        : null,
                    suffixIcon: widget.type == InputType.comment
                        ? SvgPicture.asset(
                            'assets/icons/svgs/Send_active.svg',
                            width: 20,
                            height: 20,
                            fit: BoxFit.scaleDown,
                          )
                        : null,
                  ),
                ),
              ),
              if (widget.type == InputType.password)
                Positioned(
                  right: 12,
                  top: 15.5,
                  child: SvgPicture.asset(
                    'assets/icons/svgs/_See.svg',
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      getValidateColor ?? AppColor.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
