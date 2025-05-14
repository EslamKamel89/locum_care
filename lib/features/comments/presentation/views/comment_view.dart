import 'package:flutter/material.dart';
import 'package:locum_care/features/comments/presentation/views/widgets/view_comments_widget.dart';

class CommentView extends StatefulWidget {
  const CommentView({
    super.key,
    required this.commentableType,
    required this.commentableId,
    this.showLeaveReply = true,
  });
  final String commentableType;
  final int commentableId;
  final bool showLeaveReply;
  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewCommentsWidget(
          commentableType: widget.commentableType,
          commentableId: widget.commentableId,
          showLeaveReply: widget.showLeaveReply,
        ),
      ],
    );
  }
}
