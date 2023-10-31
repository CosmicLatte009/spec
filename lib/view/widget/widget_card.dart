import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spec/controller/catchup_controller.dart';
import 'package:spec/util/app_color.dart';
import 'package:spec/util/app_text_style.dart';
import 'package:spec/view/widget/avatar/stack_avatars.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/catchup.dart';
import 'widget_catchup_like.dart';

class CardWidget extends GetView<CatchUpController> {
  final String description;
  final String thumbnail;
  final String createdTime;
  final String hashTags;
  final String url;
  final String avatar;
  final String position; // 추가
  final String nickname; // 추가
  final String postId; // 추가
  final String temperature; // 추가
  final String minibadge; // 추가

  const CardWidget({
    super.key,
    required this.minibadge,
    required this.temperature,
    required this.description,
    required this.thumbnail,
    required this.createdTime,
    required this.hashTags,
    required this.url,
    required this.position,
    required this.nickname,
    required this.avatar,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    List<String> tags =
        hashTags.split('#').where((tag) => tag.isNotEmpty).toList();

    return InkWell(
        onTap: () async {
          final Uri url = Uri.parse(this.url);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Column(children: [
          Container(
            width: 370, // Fixed width for each item
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildDescriptionSection(tags),
                  ),
                  Expanded(flex: 1, child: _buildThumbnailSection()),
                ],
              ),
            ]),
          ),
          Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  StackAvatars(
                    upLength: temperature.toString(),
                    commentLength: 0,
                  ),
                ],
              ))
        ]));
  }

  Widget _buildDescriptionSection(List<String> tags) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileAndLikeSection(),
          SizedBox(height: 10),
          _buildDescriptionText(),
          SizedBox(height: 15),
          Align(
            alignment: Alignment.bottomLeft, // 오른쪽 하단에 정렬
            child: _buildCreationTimeText(),
          ),
          SizedBox(height: 5),
          _buildTagsRow(tags),
        ],
      ),
    );
  }

  Widget _buildProfileAndLikeSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProfileSection(),
        SizedBox(width: 0),
        Align(child: LikeButtonWidget(catchUpId: postId)),
      ],
    );
  }

  Widget _buildDescriptionText() {
    return Container(
      width: 193,
      height: 38,
      child: Text(
        description,
        style: AppTextStyles.body16B(color: Colors.black),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Text _buildCreationTimeText() {
    return Text(
      createdTime,
      style: AppTextStyles.body12R(color: Colors.grey),
    );
  }

  Row _buildTagsRow(List<String> tags) {
    return Row(
      children: tags.map((tag) => _buildTagContainer(tag)).toList(),
    );
  }

  Widget _buildThumbnailSection() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: Image.asset(
        'assets/images/catchup_default.jpg',
        width: 120,
        height: 180,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTagContainer(String tag) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        height: 22,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text('#${tag}',
            softWrap: true,
            style: AppTextStyles.body12B(
              color: Color(0xFF666666),
            )),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      width: 157,
      height: 48,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMiniProfile(position.toString()),
          SizedBox(width: 8),
          Text(nickname, style: AppTextStyles.body12B(color: Colors.black)),
          SizedBox(width: 8),
          _buildProfileMiniBadge(minibadge.toString()),
        ],
      ),
    );
  }

  Widget _buildMiniProfile(String position) {
    return InkWell(
      onTap: () {},
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColor.primary05,
          ),
          Positioned(
            bottom: 10,
            child: SvgPicture.asset(
              avatar,
              width: 33,
            ),
          ),
          Positioned(
              bottom: -7.5,
              child: Container(
                  width: 43,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColor.primary80,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Center(
                      child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            position,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 6, color: Colors.white),
                            softWrap: true,
                          )))))
        ],
      ),
    );
  }

  Widget _buildProfileMiniBadge(String title) {
    return Container(
      width: 47,
      height: 22,
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
          color: Color(0xFFF3F3F3), borderRadius: BorderRadius.circular(3)),
      child: Center(
        child: Text(title,
            style: AppTextStyles.body12R(
              color: Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
            softWrap: true),
      ),
    );
  }
}
