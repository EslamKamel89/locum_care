import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/service_locator/service_locator.dart';
import 'package:locum_care/core/widgets/no_data_widget.dart';
import 'package:locum_care/features/comments/domain/models/comment_model.dart';
import 'package:locum_care/features/comments/presentation/cubits/view_comments/view_comments_cubit.dart';
import 'package:locum_care/features/comments/presentation/views/widgets/comment_create_widget.dart';
import 'package:locum_care/features/comments/presentation/views/widgets/review_widget.dart';

class ViewCommentsWidget extends StatefulWidget {
  const ViewCommentsWidget({
    super.key,
    required this.commentableType,
    required this.commentableId,
    this.showLeaveReply = true,
  });
  final String commentableType;
  final int commentableId;
  final bool showLeaveReply;

  @override
  State<ViewCommentsWidget> createState() => _ViewCommentWidgetState();
}

class _ViewCommentWidgetState extends State<ViewCommentsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ViewCommentsCubit(
            commentRepo: serviceLocator(),
            commentableType: widget.commentableType,
            commentableId: widget.commentableId,
          )..getCommentByParentType(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<ViewCommentsCubit, ViewCommentsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state.responseType == ResponseEnum.success &&
                  state.commentModelsResponse?.data?.isEmpty == true) {
                return const NoReviewsWidget();
              }
              return Column(
                children: [
                  if (widget.showLeaveReply)
                    CommentCreateWidget(
                      commentableType: widget.commentableType,
                      commentableId: widget.commentableId,
                      handleAddComment: (model) {
                        final controller = context.read<ViewCommentsCubit>();
                        controller.addComment(model);
                      },
                    ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: (state.commentModelsResponse?.data?.length ?? 0) + 1,
                    itemBuilder: (context, index) {
                      if (index < (state.commentModelsResponse?.data?.length ?? 0)) {
                        final CommentModel? commentModel =
                            state.commentModelsResponse?.data?[index];
                        if (commentModel == null) return const SizedBox();
                        return ReviewWidget(commentModel);
                      }
                      return state.responseType == ResponseEnum.loading
                          ? const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                          : const SizedBox();
                    },
                  ),
                  const SizedBox(height: 10),
                  state.commentModelsResponse?.pagination?.hasMorePages == true
                      ? ElevatedButton(
                        onPressed: () {
                          context.read<ViewCommentsCubit>().getCommentByParentType();
                        },
                        child: const Text('Load More'),
                      )
                      : const SizedBox(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
