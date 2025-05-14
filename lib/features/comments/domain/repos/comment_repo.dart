// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/features/comments/domain/models/comment_model.dart';
import 'package:locum_care/features/common_data/data/models/response_model.dart';

abstract class CommentRepo {
  Future<Either<Failure, ResponseModel<List<CommentModel>>>> getCommentByParentType({
    required GetCommentParams params,
  });
  Future<Either<Failure, CommentModel>> addComment({required AddCommentParams params});
}

class AddCommentParams {
  String? commentableType;
  int? commentableId;
  String? content;
  int? rating;
  int? parentId;
  AddCommentParams({
    this.commentableType,
    this.commentableId,
    this.content,
    this.rating,
    this.parentId,
  });

  AddCommentParams copyWith({
    String? commentableType,
    int? commentableId,
    String? content,
    int? rating,
    int? parentId,
  }) {
    return AddCommentParams(
      commentableType: commentableType ?? this.commentableType,
      commentableId: commentableId ?? this.commentableId,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{
      'commentable_type': commentableType,
      'commentable_id': commentableId,
      'content': content,
      'rating': rating,
      'parent_id': parentId,
    };
    result.removeWhere((key, value) => value == null);
    return result;
  }

  @override
  String toString() {
    return 'AddCommentParams(commentableType: $commentableType, commentableId: $commentableId, content: $content, rating: $rating, parentId: $parentId)';
  }
}

class GetCommentParams {
  String? commentableType;
  int? commentableId;
  int? limit;
  int? page;
  GetCommentParams({this.commentableType, this.commentableId, this.limit, this.page});

  @override
  String toString() {
    return 'GetCommentParams(commentableType: $commentableType, commentableId: $commentableId, limit: $limit, page: $page)';
  }

  GetCommentParams copyWith({String? parent, int? parentId, int? limit, int? page}) {
    return GetCommentParams(
      commentableType: parent ?? commentableType,
      commentableId: parentId ?? commentableId,
      limit: limit ?? this.limit,
      page: page ?? this.page,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentableType': commentableType,
      'commentableId': commentableId,
      'limit': limit,
      'page': page,
    };
  }
}
