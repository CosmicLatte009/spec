import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/view/widget/talk/comment_talk.dart';
import '../../../controller/talk/talk_controller.dart';
import '../../../model/talk.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

class CommentTalkBuilder extends StatefulWidget {
  const CommentTalkBuilder({
    super.key,
    required this.data,
    // this.myComment = false,
    // this.isLikePressed = false,
    // this.withLikebutton = true,
    this.onTalkUpdated,
  });

  final List<Talk> data;
  // final bool myComment;
  // final bool isLikePressed;
  // final bool withLikebutton;
  final VoidCallback? onTalkUpdated;

  @override
  State<CommentTalkBuilder> createState() => _CommentTalkBuilderState();
}

class _CommentTalkBuilderState extends State<CommentTalkBuilder> {
  var talkController = Get.find<TalkController>();

  bool isPressed = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Talk> activeComments = widget.data
        .where((talk) => !talk.isDeleted)
        .toList(); // 삭제되지 않은 댓글만 필터링

    if (widget.data.isEmpty) {
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
          const SizedBox(height: 8.0),
      itemBuilder: (BuildContext context, int index) {
        var comment = activeComments[index];
        return CommentTalk(
          comment: comment,
          myComment: true,
          onTalkUpdated: widget.onTalkUpdated,
        );
      },
    );
  }
}
