import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/talk/talk_controller.dart';
import '../../../model/talk/talk.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import 'my_comment_talk.dart';

class MyCommentTalkBuilder extends StatefulWidget {
  const MyCommentTalkBuilder({
    super.key,
    required this.commentData,
    this.parentTalks,
    this.onTalkUpdated,
  });

  final List<Talk> commentData;
  final Map<String, Talk?>? parentTalks;
  final VoidCallback? onTalkUpdated;

  @override
  State<MyCommentTalkBuilder> createState() => _MyCommentTalkBuilderState();
}

class _MyCommentTalkBuilderState extends State<MyCommentTalkBuilder> {
  var talkController = Get.find<TalkController>();

  bool isPressed = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Talk> activeComments = widget.commentData
        .where((talk) => !talk.isDeleted)
        .toList(); // 삭제되지 않은 댓글만 필터링
    if (widget.commentData.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Text(
            '아직 이어달린 톡이 없습니다.',
            style: AppTextStyles.body14M(color: AppColor.black60),
          ),
        ),
      );
    }
    return ListView.separated(
      controller: ScrollController(),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: activeComments.length,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 16.0),
      itemBuilder: (BuildContext context, int index) {
        var comment = activeComments[index];
        var parentTalk = widget.parentTalks?[comment.parentId];
        return Container(
          padding: const EdgeInsets.fromLTRB(6, 16, 11, 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: AppColor.white),
          child: MyCommentTalk(
            comment: comment,
            parentTalk: parentTalk,
            onTalkUpdated: widget.onTalkUpdated,
          ),
        );
      },
    );
  }
}
