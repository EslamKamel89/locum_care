import 'package:locum_care/core/api_service/api_consumer.dart';
import 'package:locum_care/core/api_service/end_points.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/comments/domain/models/comment_model.dart';
import 'package:locum_care/features/comments/domain/repos/comment_repo.dart';
import 'package:locum_care/features/common_data/data/models/response_model.dart';

class CommentRemoteDataSource {
  final ApiConsumer api;

  CommentRemoteDataSource({required this.api});
  Future<ResponseModel<List<CommentModel>>> getCommentByParentType({
    required GetCommentParams params,
  }) async {
    final t = prt('getCommentByParentType - CommentRemoteDataSource');
    final data = await api.get(EndPoint.getComments, queryParameter: params.toMap());
    ResponseModel<List<CommentModel>> response = ResponseModel.fromJson(data);
    List<CommentModel> comments =
        data['data'].map<CommentModel>((e) => CommentModel.fromJson(e)).toList();
    response.data = comments;
    return pr(response, t);
  }

  Future<CommentModel> addComment({required AddCommentParams params}) async {
    final t = prt('addComment - CommentRemoteDataSource');
    final data = await api.post(EndPoint.addComment, data: params.toMap());
    CommentModel comment = CommentModel.fromJson(data['data']);
    return pr(comment, t);
  }
}
