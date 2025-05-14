import 'package:dartz/dartz.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/features/doctor/support/domain/models/not_seen_count_model.dart';
import 'package:locum_care/features/doctor/support/domain/models/support_model.dart';

abstract class SupportRepo {
  Future<Either<Failure, List<SupportModel>>> fetchAllSupport();
  Future<Either<Failure, SupportModel>> sendSupportMessage(String content);
  Future<Either<Failure, NotSeenCountModel>> getUnseenCount();
}
