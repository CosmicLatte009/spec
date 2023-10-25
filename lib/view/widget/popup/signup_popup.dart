import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/avatar/default_avatar.dart';
import 'package:spec/view/widget/button/button_small.dart';
import 'package:spec/view/widget/custom_input.dart';
import 'package:spec/view/widget/popup/popup.dart';

class SignupPopup extends StatelessWidget {
  const SignupPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Popup(
          isWide: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //아바타
              Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  //inputs
                  const CustomInput(
                    label: '닉네임',
                    hint: '닉네임을 입력해주세요.',
                  ),
                  const CustomInput(
                    label: '이메일',
                    hint: '이메일 주소를 입력해주세요.',
                  ),
                  const CustomInput(
                    label: '휴대폰 번호',
                    hint: '휴대폰 번호를 입력해주세요.',
                  ),
                  const CustomInput(
                    label: '링크 추가',
                    hint: 'LinkedIn URL',
                  ),
                  const CustomInput(
                    hint: 'Github URL',
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: CustomInput(
                          hint: '개인 웹사이트 URL',
                        ),
                      ),
                      Expanded(
                        child: CustomInput(
                          hint: '개인 웹사이트 URL',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      ButtonSmall(
                        controller: () {},
                        text: '나중에 하기',
                        width: 165,
                        outline: true,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ButtonSmall(
                        controller: () {},
                        text: '저장하기',
                        width: 165,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Positioned(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: AppColor.primary05,
                child: Opacity(
                  opacity: 0.2,
                  child: DefaultAvatar(
                    width: 82,
                    hairPosition: -12,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '아바타 설정하기',
                      style: AppTextStyles.body12R(
                        color: AppColor.primary80,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0.0, 4.0),
                          blurRadius: 8.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: SvgPicture.asset(
                      'assets/icons/svgs/editable.svg',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
