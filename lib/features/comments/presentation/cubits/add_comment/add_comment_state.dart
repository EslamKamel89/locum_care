// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_comment_cubit.dart';

class AddCommentState {
  CommentModel? commentModel;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  AddCommentState({
    this.commentModel,
    this.errorMessage,
    this.responseType,
  });

  AddCommentState copyWith({
    CommentModel? commentModel,
    String? errorMessage,
    ResponseEnum? responseType,
  }) {
    return AddCommentState(
      commentModel: commentModel ?? this.commentModel,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
    );
  }

  @override
  String toString() =>
      'AddCommentState(commentModel: $commentModel, errorMessage: $errorMessage, responseType: $responseType)';
}
