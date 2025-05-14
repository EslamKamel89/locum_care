import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/features/auth/domain/entities/user_entity.dart';
import 'package:locum_care/features/comments/domain/models/comment_model.dart';
import 'package:locum_care/features/comments/domain/repos/comment_repo.dart';
import 'package:locum_care/features/comments/presentation/cubits/add_comment/add_comment_cubit.dart';
import 'package:locum_care/features/comments/presentation/cubits/view_comments/view_comments_cubit.dart';
import 'package:locum_care/features/comments/presentation/views/widgets/review_dialog.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';

class RepliesWidget extends StatelessWidget {
  const RepliesWidget({super.key, required this.commentModel});
  final CommentModel? commentModel;
  @override
  Widget build(BuildContext context) {
    if (commentModel == null) return const SizedBox();
    if (commentModel?.children?.isEmpty == true) return const SizedBox();
    context.watch<ViewCommentsCubit>();
    return Column(
      children: [
        ...List.generate(commentModel?.children?.length ?? 0, (index) {
          return Column(
            children: [
              SingleReplyWidget(commentModel: commentModel?.children?[index]),
              const SizedBox(height: 2),
              if (commentModel?.children?[index]?.children?.isNotEmpty == true)
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: RepliesWidget(commentModel: commentModel?.children?[index]),
                ),
            ],
          );
        }),
      ],
    );
  }
}

class SingleReplyWidget extends StatelessWidget {
  const SingleReplyWidget({super.key, required this.commentModel});

  final CommentModel? commentModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCommentCubit(serviceLocator()),
      child: BlocBuilder<AddCommentCubit, AddCommentState>(
        builder: (context, state) {
          context.watch<ViewCommentsCubit>();
          return Container(
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: context.secondaryHeaderColor, width: 3)),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.only(left: 5),
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(commentModel?.content ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(commentModel?.user?.name ?? ''),
                        Text(
                          commentModel?.user?.userType == UserType.doctor
                              ? 'Health Care Professional'
                              : 'Health Care Provider',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    subtitleTextStyle: TextStyle(color: context.primaryColor),
                  ),
                  InkWell(
                    onTap: () async {
                      await _addReply(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 5, right: 5),
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.add, color: context.secondaryHeaderColor),
                    ),
                  ),
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
        commentableType: commentModel?.commentableType,
        commentableId: commentModel?.commentableId,
        parentId: commentModel?.id,
        content: comment,
      ),
      onAddComment: (CommentModel model) {
        model.user = context.read<UserInfoCubit>().state.doctorUserModel;
        commentModel?.children = commentModel?.children ?? [];
        commentModel?.children?.insert(0, model);
      },
    );

    context.read<ViewCommentsCubit>().updateState();
  }
}
