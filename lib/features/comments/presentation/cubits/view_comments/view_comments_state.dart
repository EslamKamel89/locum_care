// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'view_comments_cubit.dart';

class ViewCommentsState {
  ResponseModel<List<CommentModel>>? commentModelsResponse;
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  String? commentableType;
  int? commentableId;
  int? limit;
  int? page;
  bool? hasNextPage;
  GetCommentParams? params;
  ViewCommentsState({
    this.commentModelsResponse,
    this.errorMessage,
    this.responseType,
    this.commentableType,
    this.commentableId,
    this.limit = 5,
    this.page = 0,
    this.hasNextPage = true,
    this.params,
  });

  ViewCommentsState copyWith({
    ResponseModel<List<CommentModel>>? commentModelsResponse,
    String? errorMessage,
    ResponseEnum? responseType,
    String? commentableType,
    int? commentableId,
    int? limit,
    int? page,
    bool? hasNextPage,
    GetCommentParams? params,
  }) {
    return ViewCommentsState(
      commentModelsResponse:
          commentModelsResponse ?? this.commentModelsResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
      commentableType: commentableType ?? this.commentableType,
      commentableId: commentableId ?? this.commentableId,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      params: params ?? this.params,
    );
  }

  @override
  String toString() {
    return 'ViewCommentsState(commentModelsResponse: $commentModelsResponse, errorMessage: $errorMessage, responseType: $responseType, commentableType: $commentableType, commentableId: $commentableId, limit: $limit, page: $page, hasNextPage: $hasNextPage, params: $params)';
  }
}
