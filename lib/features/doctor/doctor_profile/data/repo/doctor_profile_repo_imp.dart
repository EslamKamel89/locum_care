import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:locum_care/core/Errors/failure.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/features/auth/data/models/user_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_document_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_info_model.dart';
import 'package:locum_care/features/common_data/data/models/doctor_model.dart';
import 'package:locum_care/features/doctor/doctor_profile/data/remote_data_source/doctor_profile_remote_datasource.dart';
import 'package:locum_care/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';

class DoctorProfileRepoImp implements DoctorProfileRepo {
  final DoctorProfileRemoteDataSource doctorProfileRemoteDataSource;

  DoctorProfileRepoImp({required this.doctorProfileRemoteDataSource});
  @override
  Future<Either<Failure, DoctorInfoModel>> updateOrCreateDoctorInfo({
    required DoctorInfoParams params,
    required bool create,
    int? id,
  }) async {
    final t = prt('updateOrCreateDoctorInfo  - DoctorProfileRepoImp');
    try {
      DoctorInfoModel model = await doctorProfileRemoteDataSource.updateOrCreateDoctorInfo(
        params: params,
        create: create,
        id: id,
      );
      return Right(pr(model, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, DoctorModel>> updateOrCreateDoctor({
    required DoctorParams params,
    required bool create,
    int? id,
  }) async {
    final t = prt('updateOrCreateDoctor  - DoctorProfileRepoImp');
    try {
      DoctorModel model = await doctorProfileRemoteDataSource.updateOrCreateDoctor(
        params: params,
        create: create,
        id: id,
      );
      return Right(pr(model, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUserDoctor({required UserDoctorParams params}) async {
    final t = prt('updateUserDoctor  - DoctorProfileRepoImp');
    try {
      UserModel model = await doctorProfileRemoteDataSource.updateUserDoctor(params: params);
      return Right(pr(model, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, DoctorDocumentModel>> createDoctorDocument({
    required CreateDoctorDocumentParams params,
  }) async {
    final t = prt('updateOrCreateDoctorInfo  - DoctorProfileRepoImp');
    try {
      DoctorDocumentModel model = await doctorProfileRemoteDataSource.createDoctorDocument(
        params: params,
      );
      return Right(pr(model, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteDoctorDocument({required int id}) async {
    final t = prt('deleteDoctorDocument  - DoctorProfileRepoImp');
    try {
      bool result = await doctorProfileRemoteDataSource.deleteDoctorDocument(id: id);
      return Right(pr(result, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }
}
