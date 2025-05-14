import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/doctor/messages/data/remote_datasource/message_remote_datasource.dart';
import 'package:locum_care/features/doctor/messages/domain/models/message_card_model.dart';
import 'package:locum_care/features/doctor/messages/domain/repos/message_repo.dart';

class MessageRepoImp implements MessageRepo {
  final MessageRemoteDatasource remoteSource;

  MessageRepoImp({required this.remoteSource});
  @override
  Future<Either<Failure, List<MessageCardModel>>> fetchAllChat() async {
    final t = prt('fetchAllChat  - MessageRepoImp');
    try {
      List<MessageCardModel> models = await remoteSource.fetchAllChat();
      return Right(pr(models, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        pr(e.response?.data, t);
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }
}
