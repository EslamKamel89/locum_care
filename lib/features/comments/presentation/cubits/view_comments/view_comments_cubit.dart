import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/enums/response_type.dart';
import 'package:locum_care/core/globals.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/heleprs/snackbar.dart';
import 'package:locum_care/features/comments/domain/models/comment_model.dart';
import 'package:locum_care/features/comments/domain/repos/comment_repo.dart';
import 'package:locum_care/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_care/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_care/features/common_data/data/models/response_model.dart';

part 'view_comments_state.dart';

class ViewCommentsCubit extends Cubit<ViewCommentsState> {
  final CommentRepo commentRepo;
  ViewCommentsCubit({
    required this.commentRepo,
    required String commentableType,
    required int commentableId,
  }) : super(
         ViewCommentsState(
           commentableType: commentableType,
           commentableId: commentableId,
           params: GetCommentParams(commentableType: commentableType, commentableId: commentableId),
         ),
       );

  void addComment(CommentModel commentModel) async {
    final t = prt('addComment - ViewCommentsCubit');
    pr(commentModel, '$t - commentModel');
    BuildContext? context = navigatorKey.currentContext;
    if (context == null) return;
    DoctorUserModel? user = context.read<UserInfoCubit>().state.doctorUserModel;
    commentModel.user = user;
    final ResponseModel<List<CommentModel>>? comments = state.commentModelsResponse;
    comments?.data = [commentModel, ...comments.data ?? []];
    pr(comments?.data, '$t - commentModelsResponse after adding model');
    emit(state.copyWith(commentModelsResponse: comments));
  }

  void updateState() {
    final t = prt('updateState - ViewCommentsCubit');

    emit(state.copyWith());
    pr('state udpated', t);
  }

  Future getCommentByParentType() async {
    final t = prt('getCommentByParentType - ViewCommentsCubit');
    if (state.responseType == ResponseEnum.loading) {
      pr('Still loading data exiting getCommentByParentType ', t);
      return;
    }
    if (state.hasNextPage != true) {
      pr('No more pages exiting getCommentByParentType ', t);
      return;
    }

    emit(
      state.copyWith(
        responseType: ResponseEnum.loading,
        errorMessage: null,
        page: state.page! + 1,
        params: state.params?.copyWith(page: state.page! + 1, limit: state.limit),
      ),
    );

    final result = await commentRepo.getCommentByParentType(
      params: pr(state.params!, '$t params used in the request'),
    );
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (ResponseModel<List<CommentModel>> comments) async {
        pr(comments, t);
        pr(comments.pagination, t);
        comments.data = [...state.commentModelsResponse?.data ?? [], ...comments.data ?? []];
        emit(
          state.copyWith(
            commentModelsResponse: comments,
            responseType: ResponseEnum.success,
            errorMessage: null,
            hasNextPage: comments.pagination?.hasMorePages ?? false,
          ),
        );
      },
    );
  }
}
