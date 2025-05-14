import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/doctor/support/data/remote-datasource/support_remotedatasource.dart';
import 'package:locum_care/features/doctor/support/domain/models/not_seen_count_model.dart';
import 'package:locum_care/features/doctor/support/domain/models/support_model.dart';
import 'package:locum_care/features/doctor/support/domain/repos/support_repo.dart';

class SupportRepoImp implements SupportRepo {
  final SupportRemoteDatasource remoteSource;

  SupportRepoImp({required this.remoteSource});
  @override
  Future<Either<Failure, List<SupportModel>>> fetchAllSupport() async {
    final t = prt('fetchAllSupport  - SupportRepoImp');
    try {
      List<SupportModel> models = await remoteSource.fetchAllSupport();
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

  @override
  Future<Either<Failure, SupportModel>> sendSupportMessage(String content) async {
    final t = prt('sendSupportMessage  - SupportRepoImp');
    try {
      SupportModel model = await remoteSource.sendSupportMessage(content);
      return Right(pr(model, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        pr(e.response?.data, t);
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, NotSeenCountModel>> getUnseenCount() async {
    final t = prt('getUnseenCount  - SupportRepoImp');
    try {
      NotSeenCountModel model = await remoteSource.getUnseenCount();
      return Right(pr(model, t));
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
