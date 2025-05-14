import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/features/auth/domain/entities/user_entity.dart';
import 'package:locum_care/features/comments/domain/models/comment_model.dart';
import 'package:locum_care/features/comments/domain/repos/comment_repo.dart';
import 'package:locum_care/features/comments/presentation/cubits/add_comment/add_comment_cubit.dart';
import 'package:locum_care/features/comments/presentation/cubits/view_comments/view_comments_cubit.dart';
import 'package:locum_care/features/comments/presentation/views/widgets/replies_widget.dart';
import 'package:locum_care/features/comments/presentation/views/widgets/review_dialog.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget(this.commentModel, {super.key});
  final CommentModel commentModel;
  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  bool showReplies = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCommentCubit(serviceLocator()),
      child: BlocBuilder<AddCommentCubit, AddCommentState>(
        builder: (context, state) {
          context.watch<ViewCommentsCubit>();
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            shadowColor: context.secondaryHeaderColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.commentModel.user?.name ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: context.secondaryHeaderColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.commentModel.user?.userType == UserType.doctor
                        ? 'Health Care Professional'
                        : 'Health Care Provider',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  RatingBarIndicator(
                    rating: widget.commentModel.rating?.toDouble() ?? 5.0,
                    itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 20,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(height: 10),
                  Text(widget.commentModel.content ?? '', style: const TextStyle(fontSize: 16)),
                  if (widget.commentModel.children == null ||
                      widget.commentModel.children?.isNotEmpty == false)
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () async {
                          await _addReply(context);
                        },
                        child: Icon(Icons.add, color: context.secondaryHeaderColor),
                      ),
                    ),
                  if (widget.commentModel.children?.isNotEmpty == true)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  showReplies = !showReplies;
                                });
                              },
                              child: Text(
                                showReplies ? 'Hide Replies' : 'Show Replies',
                                style: TextStyle(
                                  color: context.primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await _addReply(context);
                              },
                              child: Icon(Icons.add, color: context.secondaryHeaderColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(height: 2),
                  if (showReplies) Divider(color: context.secondaryHeaderColor, thickness: 2),
                  const SizedBox(height: 2),
                  if (showReplies) RepliesWidget(commentModel: widget.commentModel),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future _addReply(BuildContext context) async {
    final String? comment = await showReviewDialog(context);
    FocusScope.of(context).unfocus();
    await context.read<AddCommentCubit>().addComment(
      params: AddCommentParams(
        commentableType: widget.commentModel.commentableType,
        commentableId: widget.commentModel.commentableId,
        parentId: widget.commentModel.id,
        content: comment,
      ),
      onAddComment: (CommentModel model) {
        widget.commentModel.children = widget.commentModel.children ?? [];
        widget.commentModel.children?.insert(0, model);
      },
    );
    // pr(widget.commentModel.children?.last, 'Last inserted reply');
    context.read<ViewCommentsCubit>().updateState();
  }
}
